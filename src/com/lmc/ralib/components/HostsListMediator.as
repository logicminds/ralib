package com.lmc.ralib.components
{
	
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.model.Hosts;
	import com.lmc.ralib.Events.RestClientEvent;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class HostsListMediator extends ViewMediatorBase
	{
		
		[Inject] public var view:HostsList;
		public function HostsListMediator()
		{
		}
		
		override public function onRegister():void
		{
			view.addEventListener("RefreshListEvent", onRefresh);
			
			getHosts();

			
		}
		private function onHostsHandler(event:ClientResultEvent):void{
			this.removeContextListener(ClientResultEvent.HOSTS, onHostsHandler);
			view.dataProvider = event.data.values;
			dispatch(new BusyPopupEvent(BusyPopupEvent.CLOSE));

		}
		public function getHosts(usecache:Boolean=true):void{
			if (view.query != null){
				usecache = false;
			}
			this.addContextListener(ClientResultEvent.HOSTS, onHostsHandler);
			dispatch(new ClientRequestEvent(ClientRequestEvent.HOSTS, usecache, view.query));
		}
		private function onRefresh(event:Event):void{
			getHosts(false);
		}
	
	}
}