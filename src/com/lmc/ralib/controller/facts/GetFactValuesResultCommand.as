package com.lmc.ralib.controller.facts
{
	import org.robotlegs.mvcs.Command;
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.model.FactValues;
	import com.lmc.ralib.Events.RestClientEvent;
	
	public class GetFactValuesResultCommand extends Command
	{
		[Inject] public var model:FactValues;
		[Inject] public var event:RestClientEvent
		public function GetFactValuesResultCommand()
		{
			super();
		}
		override public function execute():void{
			if (event.success){
				model.deepcopy(event.data);
				var resultevent:ClientResultEvent = new ClientResultEvent(ClientResultEvent.FACTVALUES,model);
				dispatch(resultevent);
			}

			
			
		}
	}
}