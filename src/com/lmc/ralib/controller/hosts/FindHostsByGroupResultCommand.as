package com.lmc.ralib.controller.hosts
{
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.Events.RestClientEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class FindHostsByGroupResultCommand extends Command
	{
		[Inject] public var event:RestClientEvent;
		public function FindHostsByGroupResultCommand()
		{
			super();
		}
		public override function execute():void{
			if (event.success){
				var resultevent:ClientResultEvent = new ClientResultEvent(ClientResultEvent.GROUP_HOSTS,event.data);
				dispatch(resultevent);
			}
			
		}
	}
}