package com.lmc.ralib.controller.Host
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.services.RemoteServiceBase;
	import com.lmc.ralib.Events.RestClientEvent;
	
	import org.robotlegs.mvcs.Command;
	public class GetHostFactsCommand extends Command
	{
		[Inject] public var remoteclient:RemoteServiceBase
		[Inject] public var event:ClientRequestEvent;
		public function GetHostFactsCommand()
		{
			super();
		}
		public override function execute():void{
			if (remoteclient.type()){
				remoteclient.gethostfacts(event.query);
			}
			else{
				dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "No Connection Profile is Selected"));
			}
		}
	}
}