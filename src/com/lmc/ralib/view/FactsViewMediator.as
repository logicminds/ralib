package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.components.ViewMediatorBase;
	import com.lmc.ralib.model.Hosts;
	
	import org.robotlegs.mvcs.Mediator;

	public class FactsViewMediator extends ViewMediatorBase
	{
		[Inject] public var view:FactsView;
		[Inject] public var hosts:Hosts;
		public function FactsViewMediator()
		{
			super();
		}
		override public function onRegister():void{
			// get the data or use cache if available
			this.addContextListener(ClientResultEvent.FACTS, onFactsHandler);
			this.view.list.addEventListener("RefreshListEvent", onRefresh);
			this.dispatch(new ClientRequestEvent(ClientRequestEvent.FACTS,true));
			if (hosts.values.length < 1){
				dispatch(new ClientRequestEvent(ClientRequestEvent.HOSTS, true));
			}
			
		}
		private function onFactsHandler(event:ClientResultEvent):void{
			dispatch(new BusyPopupEvent(BusyPopupEvent.CLOSE));

			this.removeContextListener(ClientResultEvent.FACTS, onFactsHandler);
			view.list.dataProvider = event.data.values;
		}
		private function onRefresh():void{
			this.addContextListener(ClientResultEvent.FACTS, onFactsHandler);
			this.dispatch(new ClientRequestEvent(ClientRequestEvent.FACTS,true));
		}

	}
}