package com.lmc.ralib.controller.hosts
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.Events.ClientUpdateRequestEvent;
	import com.lmc.ralib.model.HostGroups;
	import com.lmc.ralib.services.RemoteServiceBase;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateMultipleHostGroupRequestCommand extends Command
	{
		[Inject] public var event:ClientUpdateRequestEvent;
		[Inject] public var remoteclient:RemoteServiceBase;
		[Inject] public var model:HostGroups;
		
		public function UpdateMultipleHostGroupRequestCommand()
		{
			super();
		}
		public override function execute():void{
			if (remoteclient.type()){
				remoteclient.updateMultipleHostGroup(getSelectedHosts());
				var unselected:Object = getUnselectedHosts();
				if (unselected){
					remoteclient.updateMultipleHostGroup(unselected);
				}

				// Need to dispatch the loading icon and maintain this command
				//this.commandMap.detain(this);
			}
			else{
				dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "No Connection Profile is Selected"));
			}
		}
		private function getSelectedHosts():Object{
			// this will encode to json formatted string
			var selobj:Object = new Object();
			if (event.selected.length > 0){
				// set the hosts that will get the update
				selobj.host_names = event.selected;
				// set the hostgroup
				var hostobj:Object = new Object();
				hostobj.id = event.data.id.toString();
				selobj.hostgroup = hostobj;
				// do the following for the selected items
			}
			return selobj;
		}
		private function getUnselectedHosts():Object{
			var unselobj:Object = new Object();
			var k:int = 0;
			if (event.unselected.length > 0){
				// set the hosts that will get the update
				unselobj.host_names = event.unselected;
				// set the host id
				var unhostobj:Object = new Object();
				unhostobj.id = "";
				unselobj.hostgroup = unhostobj;
				
			}
			else{
				return null;
			}
			return unselobj;
		}
			
		
	}
}