package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.components.ViewMediatorBase;
	import com.lmc.ralib.model.AppKeeper;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class InfoViewMediator extends ViewMediatorBase
	{
		[Inject] public var appkeeper:AppKeeper;
		[Inject] public var view:InfoView;
		public function InfoViewMediator()
		{
			super();
		}
		public override function onRegister():void{
			this.addContextListener(ClientResultEvent.STATUS, onStatusResult);
		
			dispatch(new ClientRequestEvent(ClientRequestEvent.STATUS));
			
		}

		private function onStatusResult(event:ClientResultEvent):void{
			this.removeContextListener(ClientResultEvent.STATUS, onStatusResult);

				view.infolabel[2].info = event.data.version;
				view.infolabel.refresh();

		}
		
	}
}