package com.lmc.ralib.controller.hosts
{
	
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.model.Hosts;
	import com.lmc.ralib.services.RemoteServiceBase;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetHostsRequestCommand extends Command
	{
		[Inject] public var event:ClientRequestEvent;
		[Inject] public var remoteclient:RemoteServiceBase;
		
		[Inject] public var hosts:Hosts;
		
		public function GetHostsRequestCommand()
		{
			super();
		}
		override public function execute():void{
			// check the cache first
			if (hosts.values.length > 0 && event.usecache == true){
				var resultevent:ClientResultEvent = new ClientResultEvent(ClientResultEvent.HOSTS, hosts);
				dispatch(resultevent);
				return;
			}
			if (remoteclient.type()){
				remoteclient.gethosts(event.query);
			}
			else{
				dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "No Connection Profile is Selected"));
			}
		}
	}
}