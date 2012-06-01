package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.components.ViewMediatorBase;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.PopUpEvent;
	
	public class HostClassesViewMediator extends ViewMediatorBase
	{
		[Inject] public var view:HostClassesView;
		public function HostClassesViewMediator()
		{
			super();
		}
		public override function onRegister():void{
			dispatch(new AnalyticsTrackerEvent(AnalyticsTrackerEvent.TRACKPAGEVEW, "Host/EditClasses-RL"));
			eventMap.mapListener(view, AlertEvent.OPEN, onAlert);
			this.addViewListener(ClientUpdateRequestEvent.HOST, onHostUpdate);
			addContextListener(DataCorrelationEvent.COMBINED_CLASSES_WITH_HOST_RESULT, onHostClassesResult);
			dispatch(new DataCorrelationEvent(DataCorrelationEvent.COMBINED_CLASSES_WITH_HOST_REQUEST,null, null,null, view.data.host));
		}
		private function onHostUpdate(event:ClientUpdateRequestEvent):void{
			addContextListener(ClientUpdateResultEvent.HOST, onUpdateResult);
			dispatch(event)
		}
		private function onHostClassesResult(event:DataCorrelationEvent):void{
			removeContextListener(DataCorrelationEvent.COMBINED_CLASSES_WITH_HOST_RESULT, onHostClassesResult);
			view.list.dataProvider = event.items;
		}
		private function onUpdateResult(event:ClientUpdateResultEvent):void{
			removeContextListener(ClientUpdateResultEvent.HOST, onUpdateResult);
			if (event.success){
				view.navigator.popView();
			}

		}
		private function onAlert(event:AlertEvent):void{
			dispatch(event);
		}
	}
}