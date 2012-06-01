package com.lmc.ralib.controller.Host
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.model.Facts;
	import com.lmc.ralib.model.HostFacts;
	import com.lmc.ralib.model.Hosts;
	import com.lmc.ralib.Events.RestClientEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetHostFactsResultCommand extends Command
	{
		[Inject] public var hosts:Hosts;
		[Inject] public var event:RestClientEvent;
		public function GetHostFactsResultCommand()
		{
			super();
		}
		public override function execute():void{
			if (event.success){
				var facts:HostFacts = event.data;
				// TODO decide if we need to loosely attach the facts to the host
				// Was thinking of attaching the facts to the host but don't want to eat too much memory
				//	var hostname:String = facts.namehash["fqdn"]
				//	hosts.findbyname(hostname).facts.cloneInto(facts);
				if (facts.values.length < 1){
					dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "There are no facts for the given host" ));
				}
				
				var evt:ClientResultEvent = new ClientResultEvent(ClientResultEvent.HOSTFACTS, facts);
				dispatch(evt);
			}
			
			
		}
	
	}
}