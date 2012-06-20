package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.Events.FactViewEvent;
	import com.lmc.ralib.components.ViewMediatorBase;
	import com.lmc.ralib.model.Host;
	import com.lmc.ralib.model.Hosts;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.View;
	import spark.events.IndexChangeEvent;

	public class FactSystemsViewMediator extends ViewMediatorBase
	{
		[Inject] public var view:FactSystemsView;
		public function FactSystemsViewMediator()
		{
			super();
		}
		public override function onRegister():void{
			this.addViewListener(FactViewEvent.CREATE_HOSTS_FACT_EMAIL, dispatch);
			this.addContextListener(ClientResultEvent.HOSTS, onHosts);
			dispatch(new ClientRequestEvent(ClientRequestEvent.HOSTS, true));
		}
		private function onHosts(event:ClientResultEvent):void{
			this.removeContextListener(ClientResultEvent.HOSTS, onHosts);
			view.allhosts = event.data;
		}
		
	}
}