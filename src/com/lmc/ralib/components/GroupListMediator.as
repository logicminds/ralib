package com.lmc.ralib.components
{
	import com.lmc.ralib.Events.*;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;

	public class GroupListMediator extends ViewMediatorBase
	{
		[Inject] public var list:GroupList;
		public function GroupListMediator()
		{
			super();
		}
		override public function onRegister():void
		{
			this.addViewListener("RefreshListEvent", onRefresh);
			this.addContextListener(ClientResultEvent.HOSTGROUPS, onGroupsResult);
			this.dispatch(new ClientRequestEvent(ClientRequestEvent.HOSTGROUPS, true));
			
		}
		private function onRefresh(event:Event):void{
			this.addContextListener(ClientResultEvent.HOSTGROUPS, onGroupsResult);
			this.dispatch(new ClientRequestEvent(ClientRequestEvent.HOSTGROUPS, false));
		}
		private function onGroupsResult(event:ClientResultEvent):void{
			list.dataProvider = event.data.values;
			this.removeContextListener(ClientResultEvent.HOSTGROUPS, onGroupsResult);
			//dispatch(new BusyPopupEvent(BusyPopupEvent.CLOSE));


		}
	}
}