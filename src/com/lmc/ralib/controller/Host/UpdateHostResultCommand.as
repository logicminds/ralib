package com.lmc.ralib.controller.Host
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.ClientUpdateResultEvent;
	import com.lmc.ralib.Events.RestClientEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateHostResultCommand extends Command
	{
		[Inject] public var event:RestClientEvent;
		public function UpdateHostResultCommand()
		{
			super();
		}
		public override function execute():void{
			switch(event.statuscode){
				case 200:
					dispatch(new ClientUpdateResultEvent(ClientUpdateResultEvent.HOST,-1,null,true));
					dispatch(new AlertEvent(AlertEvent.OPEN,"Notice", "Host Was Updated Successfully"));
					break;
				default:
					dispatch(new ClientUpdateResultEvent(ClientUpdateResultEvent.HOST, -1,null,false));
					dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "There was a problem updating, Error: " + event.statuscode ));
					
			}
		}
	}
}