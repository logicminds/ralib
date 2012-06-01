package com.lmc.ralib.controller.Application
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.services.RemoteService;
	import com.lmc.ralib.services.RemoteServiceBase;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetClientStatusCommand extends Command
	{
		[Inject] public var remoteservice:RemoteService;
		[Inject] public var event:ClientRequestEvent;
		[Inject] public var remoteclient:RemoteServiceBase;

		public function GetClientStatusCommand()
		{
			super();
		}
		public override function execute():void{
		// check the cache first
			if (event.profile){
				if (event.profile.clienttype){
					// get a one time use client
					var testremoteclient:RemoteServiceBase = remoteservice.getService(event.profile);
					this.injector.injectInto(testremoteclient);
					testremoteclient.getstatus();
				}

			}
			else{
				// try the current profile
				if (remoteclient.type()){
					remoteclient.getstatus();
				}
			}
			
		}
	}
	
}