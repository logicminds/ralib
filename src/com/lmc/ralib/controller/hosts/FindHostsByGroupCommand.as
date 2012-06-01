package com.lmc.ralib.controller.hosts
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.SearchEvent;
	import com.lmc.ralib.services.RemoteServiceBase;
	import com.lmc.ralib.Events.RestClientEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class FindHostsByGroupCommand extends Command
	{
		[Inject] public var remoteclient:RemoteServiceBase
		[Inject] public var event:SearchEvent;
		public function FindHostsByGroupCommand()
		{
			super();
		}
		public override function execute():void{
			var query:String = "";

			if (event.hostgroup){
				query += "hostgroup%3D" + event.hostgroup;
			}
			else if (event.hostgroups){
				// cycle through list and create search query
				for each (var obj:Object in event.hostgroups){
					query += "hostgroup%3D";
					query += obj.name;
					query += "+or"
				}
			}
			if (remoteclient.type()){
				remoteclient.gethosts(query, RestClientEvent.GROUP_HOSTS);
			}
			else{
				dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "No Connection Profile is Selected"));
			}
		}
	}
}