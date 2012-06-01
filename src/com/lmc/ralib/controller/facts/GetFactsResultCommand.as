package com.lmc.ralib.controller.facts
{
	import com.lmc.ralib.Events.BusyPopupEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.model.Facts;
	import com.lmc.ralib.Events.RestClientEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetFactsResultCommand extends Command
	{
		[Inject] public var model:Facts;
		[Inject] public var event:RestClientEvent
		public function GetFactsResultCommand()
		{
			super();
		}
		override public function execute():void{
			if (event.success){

				model.cloneInto(event.data);
				var resultevent:ClientResultEvent = new ClientResultEvent(ClientResultEvent.FACTS,model);
				dispatch(resultevent);
			}
			
		}
	}
}