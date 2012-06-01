package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.FactViewEvent;
	import com.lmc.ralib.components.ViewMediatorBase;
	import com.lmc.ralib.model.Host;
	import com.lmc.ralib.model.Hosts;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.View;
	import spark.events.IndexChangeEvent;

	public class FactSystemsViewMediator extends ViewMediatorBase
	{
		[Inject] public var hosts:Hosts;
		[Inject] public var view:FactSystemsView;
		public function FactSystemsViewMediator()
		{
			super();
		}
		public override function onRegister():void{
			this.addViewListener(FactViewEvent.CREATE_HOSTS_FACT_EMAIL, dispatch);
			view.allhosts = hosts;
		}
		
	}
}