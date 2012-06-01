package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.AnalyticsTrackerEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ClientWriteRequestEvent;
	import com.lmc.ralib.Events.ClientWriteResultEvent;
	import com.lmc.ralib.Events.DialogPopUpEvent;
	import com.lmc.ralib.components.ViewMediatorBase;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.PopUpEvent;

	public class HostGroupsViewMediator extends ViewMediatorBase
	{
		[Inject] public var view:HostGroupsView;
		public function HostGroupsViewMediator()
		{
			super();
		}
		public override function onRegister():void{
			dispatch(new AnalyticsTrackerEvent(AnalyticsTrackerEvent.TRACKPAGEVEW, "/groups-RL"));
			// show the dialog popup
			addViewListener(DialogPopUpEvent.OPEN, openDialog);
			//get hosts in case we need them
			//dispatch(new ClientRequestEvent(ClientRequestEvent.HOSTS, true));
			

		}
		private function onCreateClose(event:PopUpEvent):void{
			removeContextListener(PopUpEvent.CLOSE, onCreateClose);
			if (event.data){
				var hostgroup:Object = new Object();
				hostgroup.name = event.data.name;
				this.addContextListener(ClientWriteResultEvent.HOSTGROUP_CREATED, onGroupCreated);
				this.dispatch(new ClientWriteRequestEvent(ClientWriteRequestEvent.CREATE_HOSTGROUP,{hostgroup:hostgroup}));
			}
		}
		private function openDialog(event:DialogPopUpEvent):void{
			// listen for when the user saves
			addContextListener(PopUpEvent.CLOSE, onCreateClose);
			dispatch(event);
		}
	
		private function onGroupCreated(event:ClientWriteResultEvent):void{
			this.removeContextListener(ClientWriteResultEvent.HOSTGROUP_CREATED, onGroupCreated);
			view.list.refreshlist(false);
		}
	}
}