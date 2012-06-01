package com.lmc.ralib.controller.hosts
{
	import org.robotlegs.mvcs.Command;
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.ClientUpdateResultEvent;
	import com.lmc.ralib.Events.RestClientEvent;
	
	public class UpdateMultipleHostGroupResultCommand extends Command
	{
		[Inject] public var event:RestClientEvent;

		public function UpdateMultipleHostGroupResultCommand()
		{
			super();
		}
		public override function execute():void{
			switch(event.statuscode){
				case 200:
					dispatch(new AlertEvent(AlertEvent.OPEN,"Notice", "Hosts Were Updated Successfully"));
					dispatch(new ClientUpdateResultEvent(ClientUpdateResultEvent.MULTIPLE_HOSTGROUP));
					break;
				case 302:
					dispatch(new AlertEvent(AlertEvent.OPEN,"Notice", "Hosts Were Updated Successfully"));
					dispatch(new ClientUpdateResultEvent(ClientUpdateResultEvent.MULTIPLE_HOSTGROUP));
					break;
				default:
					dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "There was a problem updating the hosts, Error: " + event.statuscode ));
					dispatch(new ClientUpdateResultEvent(ClientUpdateResultEvent.MULTIPLE_HOSTGROUP));
					break;
					
			}
			
		}
	}
}