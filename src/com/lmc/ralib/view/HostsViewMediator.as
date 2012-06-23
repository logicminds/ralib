package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.components.HostsList;
	import com.lmc.ralib.components.ViewMediatorBase;
	import com.lmc.ralib.model.*;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.events.CloseEvent;
	
	import org.robotlegs.mvcs.Mediator;

	public class HostsViewMediator extends ViewMediatorBase
	{
		public function HostsViewMediator()
		{
			super();
		}
		
		[Inject] public var view:HostsView;
		
		override public function onRegister():void{
		//	this.eventMap.mapListener(view.addbutt,MouseEvent.CLICK, onMouseClick);
		//	this.addContextListener(SystemModelEvent.SYSTEM_ADDED, onAdded);
		//	this.addContextListener(CloseEvent.CLOSE, onAlertClose);
			view.addEventListener("HostsRefreshListEvent", onRefresh);
			getHosts();
		}
		private function onAlertClose(event:CloseEvent):void{
			trace("alert closed");
		}
	
		private function onMouseClick(event:MouseEvent):void{
			//var sys:String = view.systemtext.text;
			//dispatch(new SystemModelEvent(SystemModelEvent.ADD_REQUEST, sys));
		
		}
		private function onAdded(event:SystemModelEvent):void{
			//view.systemtext.text = "";
			//dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", event.system + " was added"));
			
		}
		private function onHostsHandler(event:ClientResultEvent):void{
			this.removeContextListener(ClientResultEvent.HOSTS, onHostsHandler);
			view.hostslist.dataProvider = event.data.values;
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