package com.lmc.ralib.controller.groups
{
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.model.HostGroup;
	import com.lmc.ralib.model.HostGroups;
	import com.lmc.ralib.Events.RestClientEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetHostGroupResultCommand extends Command
	{
		[Inject] public var groups:HostGroups;
		[Inject] public var event:RestClientEvent;
		public function GetHostGroupResultCommand()
		{
			super();
		}
		override public function execute():void{
			if (event.success){

				var group:HostGroup = groups.findbyname(event.data.name);
				group.cloneinto(event.data);
				var resultevent:ClientResultEvent = new ClientResultEvent(ClientResultEvent.HOSTGROUP,group);
				dispatch(resultevent);
			}
			
		}
	}
}