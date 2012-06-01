package com.lmc.ralib.controller.groups
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.BusyPopupEvent;
	import com.lmc.ralib.Events.ClientWriteRequestEvent;
	import com.lmc.ralib.services.RemoteServiceBase;
	
	import org.robotlegs.mvcs.Command;
	
	public class CreateGroupRequestCommand extends Command
	{
		[Inject] public var event:ClientWriteRequestEvent
		[Inject] public var remoteclient:RemoteServiceBase
		
		public function CreateGroupRequestCommand()
		{
			super();
		}
		override public function execute():void{
			if (remoteclient.type()){
				remoteclient.createGroup(event.data);
			}
			else{
				dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "No Connection Profile is Selected"));
			}
		}
	}
}