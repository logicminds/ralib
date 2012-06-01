package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.components.ViewMediatorBase;
	import com.lmc.ralib.model.Facts;
	import com.lmc.ralib.model.HostFacts;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class HostFactsViewMediator extends ViewMediatorBase
	{
		[Inject] public var view:HostFactsView;
		public function HostFactsViewMediator()
		{
			super();
		}
		public override function onRegister():void{
			// get the facts
			addContextListener(ClientResultEvent.HOSTFACTS, onFactsHandler);
			this.eventMap.mapListener(view, "RefreshRequested", onRefresh);
			dispatch(new ClientRequestEvent(ClientRequestEvent.HOSTFACTS, true, view.data.host.name));
		}
		private function onFactsHandler(event:ClientResultEvent):void{
			removeContextListener(ClientResultEvent.HOSTFACTS, onFactsHandler);
			view.list.dataProvider = (event.data as HostFacts).values;
		}
		private function onRefresh(event:Event):void{
			addContextListener(ClientResultEvent.HOSTFACTS, onFactsHandler);
			dispatch(new ClientRequestEvent(ClientRequestEvent.HOSTFACTS, true, view.data.host.name));


		}
	}
}