package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.components.ViewMediatorBase;
	import com.lmc.ralib.model.Host;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	
	public class HostViewMediator extends ViewMediatorBase
	{
		[Inject] public var view:HostView;
		private var usecache:Boolean = true;
		public function HostViewMediator()
		{
			super();
		}
		override public function onRegister():void{
			// get host information
			addViewListener(ChangeViewEvent.LOAD_VIEW, dispatch);
			addContextListener(ClientResultEvent.HOST, onhostHandler);
			dispatch(new ClientRequestEvent(ClientRequestEvent.HOST, false,view.host.name ));
			//ensure we have all the groups
			dispatch(new ClientRequestEvent(ClientRequestEvent.HOSTGROUPS, usecache));
			//ensure we have all the classes
			dispatch(new ClientRequestEvent(ClientRequestEvent.PUPPETCLASSES, usecache));
			this.addContextListener(MenuEvent.RESULT_HOST_MENU, onMenuHandler);
			dispatch(new MenuEvent(MenuEvent.GET_HOST_MENU));
			
		}
		private function onMenuHandler(event:MenuEvent):void{
			this.removeContextListener(MenuEvent.RESULT_HOST_MENU, onMenuHandler);
			view.list.dataProvider = event.data;
		}
		private function onhostHandler(event:ClientResultEvent):void{
			removeContextListener(ClientResultEvent.HOST, onhostHandler);
			view.data.host = event.data as Host;
		}
		private function onRefresh(event:Event):void{
			addContextListener(ClientResultEvent.HOST, onhostHandler);
			dispatch(new ClientRequestEvent(ClientRequestEvent.HOST, false, view.host.name ));
			//ensure we have all the groups
			dispatch(new ClientRequestEvent(ClientRequestEvent.HOSTGROUPS, usecache));
			dispatch(new ClientRequestEvent(ClientRequestEvent.PUPPETCLASSES, usecache));
		
		}
	}
}