package com.lmc.ralib.controller.groups
{
	import com.lmc.ralib.Events.BusyPopupEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.model.HostGroups;
	import com.lmc.ralib.Events.RestClientEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetGroupsResultCommand extends Command
	{
		[Inject] public var model:HostGroups;
		[Inject] public var event:RestClientEvent;
		public function GetGroupsResultCommand()
		{
			super();
		}
		override public function execute():void{
			if (event.success){

				model.cloneInto(event.data);
				var resultevent:ClientResultEvent = new ClientResultEvent(ClientResultEvent.HOSTGROUPS,model);
				dispatch(resultevent);
			}
			
						
		}
	}
}