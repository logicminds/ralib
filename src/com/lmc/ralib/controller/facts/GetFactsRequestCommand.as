package com.lmc.ralib.controller.facts
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.BusyPopupEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.model.Facts;
	import com.lmc.ralib.services.RemoteServiceBase;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetFactsRequestCommand extends Command
	{
		[Inject] public var event:ClientRequestEvent;
		[Inject] public var remoteclient:RemoteServiceBase;

		
		[Inject] public var facts:Facts;
		
		public function GetFactsRequestCommand()
		{
			super();
		}
		override public function execute():void{
			// check the cache first
			if (facts.values.length > 0 && event.usecache == true){
				var resultevent:ClientResultEvent = new ClientResultEvent(ClientResultEvent.FACTS, facts);
				dispatch(resultevent);
				return;
			}
			if (remoteclient.type()){
				remoteclient.getfacts();
			
				// Need to dispatch the loading icon and maintain this command
				//this.commandMap.detain(this);
			}
			else{
				dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "No Connection Profile is Selected"));
			}
		}
	}
}