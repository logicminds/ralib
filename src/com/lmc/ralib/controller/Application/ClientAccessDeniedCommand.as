package com.lmc.ralib.controller.Application
{
	import com.lmc.ralib.Events.RestClientEvent;
	import com.lmc.ralib.Events.*;
	import org.robotlegs.mvcs.Command;
	
	public class ClientAccessDeniedCommand extends Command
	{
		[Inject] public var event:RestClientEvent
		public function ClientAccessDeniedCommand()
		{
			super();
		}
		override public function execute():void{
				dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "Access Denied: " + event.message));
		}
	}
}