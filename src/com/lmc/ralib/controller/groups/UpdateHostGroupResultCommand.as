package com.lmc.ralib.controller.groups
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.ClientUpdateResultEvent;
	import com.lmc.ralib.Events.RestClientEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateHostGroupResultCommand extends Command
	{
		[Inject] public var event:RestClientEvent;
		public function UpdateHostGroupResultCommand()
		{
			super();
		}
		public override function execute():void{
			switch(event.statuscode){
				case 200:
					dispatch(new AlertEvent(AlertEvent.OPEN,"Notice", "HostGroup Was Updated Successfully"));
					dispatch(new ClientUpdateResultEvent(ClientUpdateResultEvent.HOSTGROUP));
					break;
				default:
					dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "There was a problem updating, Error: " + event.statuscode ));
					dispatch(new ClientUpdateResultEvent(ClientUpdateResultEvent.HOSTGROUP));

			}
				
		}
	}
}