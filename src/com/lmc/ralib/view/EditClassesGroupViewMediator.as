package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.components.ViewMediatorBase;
	
	import mx.events.CloseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class EditClassesGroupViewMediator extends ViewMediatorBase
	{
		[Inject] public var view:EditClassesGroupView;
		public function EditClassesGroupViewMediator()
		{
			super();
		}
		public override function onRegister():void{
			// not sure why I need this alert listener
			eventMap.mapListener(view, AlertEvent.OPEN, dispatch);
			
			addContextListener(ClientUpdateResultEvent.HOSTGROUP, onUpdate);
			dispatch(new AnalyticsTrackerEvent(AnalyticsTrackerEvent.TRACKPAGEVEW, "Group/EditClasses-RL"));

			dispatch(new BusyPopupEvent(BusyPopupEvent.OPEN, "Processing"));
			addContextListener(DataCorrelationEvent.COMBINED_CLASSES_WITH_GROUP_RESULT, onCorrelationResult);
			dispatch(new DataCorrelationEvent(DataCorrelationEvent.COMBINED_CLASSES_WITH_GROUP_REQUEST,null, null,view.data.gdata));
			
			addViewListener(ClientUpdateRequestEvent.HOSTGROUP, onHostGroupUpdate);
		}
	
		private function onHostGroupUpdate(event:ClientUpdateRequestEvent):void{
			//dispatchevent and listen for event
			addContextListener(ClientUpdateResultEvent.HOSTGROUP, onHostGroupUpdateResult);
			dispatch(event);
		}
		private function onHostGroupUpdateResult(event:ClientUpdateResultEvent):void{
			// do nothing as the result command handles the event
			removeContextListener(ClientUpdateResultEvent.HOSTGROUP, onHostGroupUpdateResult);

		}

		private function onCorrelationResult(event:DataCorrelationEvent):void{
			removeContextListener(DataCorrelationEvent.COMBINED_CLASSES_WITH_GROUP_RESULT, onCorrelationResult);
			view.list.dataProvider = event.items;
			dispatch(new BusyPopupEvent(BusyPopupEvent.CLOSE));
			
		}
		private function onConfirmClose(event:CloseEvent):void{
			//message is passed back to user via alert
			removeContextListener(CloseEvent.CLOSE, onConfirmClose);
			removeViewListener(ClientUpdateRequestEvent.HOSTGROUP, onHostGroupUpdate);
			view.navigator.popView();
		}
		private function onUpdate(event:ClientUpdateResultEvent):void{
			addContextListener(CloseEvent.CLOSE, onConfirmClose);
			removeContextListener(ClientUpdateResultEvent.HOSTGROUP, onUpdate);
		}
	}
}