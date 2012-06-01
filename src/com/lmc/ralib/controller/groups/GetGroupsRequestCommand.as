package com.lmc.ralib.controller.groups
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.BusyPopupEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.model.HostGroups;
	import com.lmc.ralib.services.RemoteServiceBase;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetGroupsRequestCommand extends Command
	{
		[Inject] public var event:ClientRequestEvent;
		[Inject] public var remoteclient:RemoteServiceBase;
		[Inject] public var model:HostGroups;
		public function GetGroupsRequestCommand()
		{
			super();
		}
		override public function execute():void{
			// check the cache first
			if (model.values.length > 0 && event.usecache == true){
				var resultevent:ClientResultEvent = new ClientResultEvent(ClientResultEvent.HOSTGROUPS, model);
				dispatch(resultevent);
				return;
			}
		
			if (remoteclient.type()){
				
				remoteclient.gethostgroups();
				// Need to dispatch the loading icon and maintain this command
				//this.commandMap.detain(this);
			}
			else{
				dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "No Connection Profile is Selected"));
			}
		}
	}
}