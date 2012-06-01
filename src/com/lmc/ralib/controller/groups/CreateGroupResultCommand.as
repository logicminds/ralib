package com.lmc.ralib.controller.groups
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.BusyPopupEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ClientWriteRequestEvent;
	import com.lmc.ralib.Events.ClientWriteResultEvent;
	import com.lmc.ralib.Events.RestClientEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class CreateGroupResultCommand extends Command
	{
		[Inject] public var event:RestClientEvent;
		public function CreateGroupResultCommand()
		{
			super();
		}
		override public function execute():void{
			var evt:ClientWriteResultEvent;
			// need to determine if hostgroup was created
			switch (event.statuscode){
				case 201:
					// tell listener that group was created
					evt = new ClientWriteResultEvent(ClientWriteResultEvent.HOSTGROUP_CREATED,true);
					this.dispatch(evt);
					// dispatch dialog that group was created
					dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "Group Was Created Successfully"));
					// refresh hostgroups
					this.dispatch(new ClientRequestEvent(ClientRequestEvent.HOSTGROUPS, false));
					break;
				/*case 422:
					dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "Group Already Exists with that name"));
					// tell listener that group was created
					this.dispatch(new ClientWriteResultEvent(ClientWriteResultEvent.HOSTGROUP_CREATED, false));
					break; */
				default:
				/*	dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "Failed to Create Group"));
					// tell listener that group was created
					this.dispatch(new ClientWriteResultEvent(ClientWriteResultEvent.HOSTGROUP_CREATED, false));
					break;
					*/
			}
			
		}
	}
}