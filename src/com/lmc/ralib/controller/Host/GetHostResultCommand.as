package com.lmc.ralib.controller.Host
{
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.model.Host;
	import com.lmc.ralib.model.Hosts;
	import com.lmc.ralib.Events.RestClientEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetHostResultCommand extends Command
	{
		[Inject] public var event:RestClientEvent;
		[Inject] public var hosts:Hosts;
		public function GetHostResultCommand()
		{
			super();
		}
		public override function execute():void{
			//the host may not be in the list if the hosts list doesn't exist yet
			if (hosts.values.length < 1){
				this.eventDispatcher.addEventListener(ClientResultEvent.HOSTS, onHostsResult);
				dispatch(new ClientRequestEvent(ClientRequestEvent.HOSTS,true));
				commandMap.detain(this);
			}
			else{
				process();
			}
		}
		private function onHostsResult(event:ClientResultEvent):void{
			process();
		}
		private function process():void{
			var host:Host;
			if (event.data){
				host = hosts.findbyname(event.data.name);
				if (host){
					host.cloneinto(event.data as Host);
				}
			}
			
			dispatch(new ClientResultEvent(ClientResultEvent.HOST, host));
			commandMap.release(this);
		}
	}
}