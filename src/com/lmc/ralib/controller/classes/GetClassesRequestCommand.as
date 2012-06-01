package com.lmc.ralib.controller.classes
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.BusyPopupEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.model.PuppetClasses;
	import com.lmc.ralib.services.RemoteServiceBase;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetClassesRequestCommand extends Command
	{
		[Inject] public var event:ClientRequestEvent;
		[Inject] public var remoteclient:RemoteServiceBase;
		[Inject] public var model:PuppetClasses;
		public function GetClassesRequestCommand()
		{
			super();
		}
		public override function execute():void{
			// check the cache first
			if (model.values.length > 0 && event.usecache == true){
				var resultevent:ClientResultEvent = new ClientResultEvent(ClientResultEvent.PUPPETCLASSES, model );
				dispatch(resultevent);
				return;
			}
			if (remoteclient.type()){
				remoteclient.getclasses();
			}
			else{
				dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "No Connection Profile is Selected"));
			}
		}
	}
}