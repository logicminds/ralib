package com.lmc.ralib.controller.Host
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.ClientUpdateRequestEvent;
	import com.lmc.ralib.model.Host;
	import com.lmc.ralib.services.RemoteServiceBase;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateHostRequestCommand extends Command
	{
		[Inject] public var remoteclient:RemoteServiceBase;

		[Inject] public var event:ClientUpdateRequestEvent;
		public function UpdateHostRequestCommand()
		{
			super();
		}
		public override function execute():void{
			var host:Host = event.data;
			var obj:Object = host.toForemanObject();
			var hostobj:Object = new Object();
			hostobj.puppetclass_ids = event.selected;
			obj.host = hostobj;
			
			if (remoteclient.type()){
				// this will update any thing new about the host
				remoteclient.updateHost(obj, event.data.name);
			}
			else{
				dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "No Connection Profile is Selected"));
			}			
		}
		
	}
}