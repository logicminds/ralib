package com.lmc.ralib.controller.Host
{
	import org.robotlegs.mvcs.Command;
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.BusyPopupEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.services.RemoteServiceBase;
	public class GetHostClassesCommand extends Command
	{
		[Inject] public var event:ClientRequestEvent;
		[Inject] public var remoteclient:RemoteServiceBase;
		public function GetHostClassesCommand()
		{
			super();
		}
		public override function execute():void{
			if (remoteclient.type()){
				remoteclient.gethostclasses(event.query);
			}
			else{
				dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "No Connection Profile is Selected"));
			}
		}
	}
}