package com.lmc.ralib.controller.groups
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.model.HostGroup;
	
	import com.lmc.ralib.services.RemoteServiceBase;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetHostGroupRequestCommand extends Command
	{
		[Inject] public var event:ClientRequestEvent;
		[Inject] public var remoteclient:RemoteServiceBase;

		public function GetHostGroupRequestCommand()
		{
			super();
		}
		override public function execute():void{
			if (remoteclient.type()){
				remoteclient.gethostgroup(event.resourceid.toString());
			}
			else{
				dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "No Connection Profile is Selected"));
			}
		}
	}
}