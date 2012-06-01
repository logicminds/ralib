package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.AnalyticsTrackerEvent;
	import com.lmc.ralib.Events.BusyPopupEvent;
	import com.lmc.ralib.Events.ClientUpdateRequestEvent;
	import com.lmc.ralib.Events.DataCorrelationEvent;
	import com.lmc.ralib.Events.SearchEvent;
	import com.lmc.ralib.components.ViewMediatorBase;
	
	import mx.events.CloseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class EditHostsGroupViewMediator extends ViewMediatorBase
	{
		[Inject] public var view:EditHostsGroupView;
		
		public function EditHostsGroupViewMediator()
		{
			super();
		}
		public override function onRegister():void{
			this.eventMap.mapListener(view, AlertEvent.OPEN, dispatch);
			eventMap.mapListener(view, ClientUpdateRequestEvent.MULTIPLE_HOSTGROUP, onSaveEvent);
			dispatch(new AnalyticsTrackerEvent(AnalyticsTrackerEvent.TRACKPAGEVEW, "Group/EditHosts-RL"));
			addContextListener(ClientResultEvent.GROUP_HOSTS, onHostsResult);
			dispatch(new SearchEvent(SearchEvent.FIND_HOSTS_BY_GROUP, view.data.gdata.name));
		}
		private function onSaveEvent(event:ClientUpdateRequestEvent):void{
			this.addContextListener(CloseEvent.CLOSE, onConfirmClose);
			addContextListener(ClientUpdateResultEvent.MULTIPLE_HOSTGROUP, onSaveResult);
			dispatch(event);
		}
		private function onSaveResult(event:ClientUpdateResultEvent):void{
			removeContextListener(ClientUpdateResultEvent.MULTIPLE_HOSTGROUP, onSaveResult);
		}
		private function onConfirmClose(event:CloseEvent):void{
			removeContextListener(CloseEvent.CLOSE, onConfirmClose);

			view.navigator.popView();
		}
		private function onHostsResult(event:ClientResultEvent):void{
			dispatch(new BusyPopupEvent(BusyPopupEvent.OPEN, "Processing"));
			addContextListener(DataCorrelationEvent.HOSTS_WITH_HOSTGROUP_RESULT, onCorrelationResult);
			dispatch(new DataCorrelationEvent(DataCorrelationEvent.HOSTS_WITH_HOSTGROUP_REQUEST,null, event.data));
		}
		private function onCorrelationResult(event:DataCorrelationEvent):void{
			view.list.dataProvider = event.items;
			dispatch(new BusyPopupEvent(BusyPopupEvent.CLOSE));

		}
	}
}