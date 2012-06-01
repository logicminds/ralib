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
			eventMap.mapListener(view, AlertEvent.OPEN, dispatch);
			addContextListener(ClientUpdateResultEvent.HOSTGROUP, onUpdate);
			dispatch(new AnalyticsTrackerEvent(AnalyticsTrackerEvent.TRACKPAGEVEW, "Group/EditClasses-RL"));
			dispatch(new BusyPopupEvent(BusyPopupEvent.OPEN, "Processing"));
			addContextListener(DataCorrelationEvent.COMBINED_CLASSES_WITH_GROUP_RESULT, onCorrelationResult);
			eventMap.mapListener(view, ClientUpdateRequestEvent.HOSTGROUP, dispatch);
			dispatch(new DataCorrelationEvent(DataCorrelationEvent.COMBINED_CLASSES_WITH_GROUP_REQUEST,null, null,view.data.gdata));
		}
		
		private function onCorrelationResult(event:DataCorrelationEvent):void{
			view.list.dataProvider = event.items;
			dispatch(new BusyPopupEvent(BusyPopupEvent.CLOSE));
			
		}
		private function onConfirmClose(event:CloseEvent):void{
			removeContextListener(CloseEvent.CLOSE, onConfirmClose);
			view.navigator.popView();
		}
		private function onUpdate(event:ClientUpdateResultEvent):void{
			addContextListener(CloseEvent.CLOSE, onConfirmClose);
			removeContextListener(ClientUpdateResultEvent.HOSTGROUP, onUpdate);
		}
	}
}