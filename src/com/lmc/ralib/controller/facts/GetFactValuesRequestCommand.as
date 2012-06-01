package com.lmc.ralib.controller.facts
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.BusyPopupEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.model.FactValues;
	import com.lmc.ralib.services.RemoteServiceBase;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetFactValuesRequestCommand extends Command
	{
		[Inject] public var event:ClientRequestEvent;
		[Inject] public var remoteclient:RemoteServiceBase;

		[Inject] public var model:FactValues;
		
		public function GetFactValuesRequestCommand()
		{
			super();
		}
		override public function execute():void{
			// check the cache first
			if (model.values.length > 0 && event.usecache == true){
				var resultevent:ClientResultEvent = new ClientResultEvent(ClientResultEvent.FACTS, model);
				dispatch(resultevent);
				return;
			}
			if (remoteclient.type()){
				remoteclient.getfactvalues(event.query);
			
				
			}
			else{
				dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "No Connection Profile is Selected"));
			}
		}
	}
}