package com.lmc.ralib.controller.groups
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.Events.ClientUpdateRequestEvent;
	import com.lmc.ralib.model.HostGroup;
	import com.lmc.ralib.model.HostGroups;
	import com.lmc.ralib.model.PuppetClass;
	import com.lmc.ralib.model.PuppetClasses;
	import com.lmc.ralib.services.RemoteServiceBase;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateHostGroupRequestCommand extends Command
	{
		[Inject] public var event:ClientUpdateRequestEvent;
		[Inject] public var remoteclient:RemoteServiceBase;
		[Inject] public var groups:HostGroups;
		[Inject] public var classes:PuppetClasses;
		public function UpdateHostGroupRequestCommand()
		{
			super();
		}
		public override function execute():void{
			if (remoteclient.type()){
				// this will update any thing new about the hostgroup
				remoteclient.updateHostGroup(createGroupObj());
			}
			else{
				dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "No Connection Profile is Selected"));
			}
		}
		private function createGroupObj():Object{
			var classitem:PuppetClass;
			//find hostgroup
			var group:HostGroup = event.data as HostGroup;
			// update hostgroup with added classes by removing and adding
			group.puppetclasses.removeAll();
			for each (var pclass:Object in event.selected){
				classitem = classes.findbyname(pclass.name) as PuppetClass;
				group.puppetclasses.addItem(classitem);
			}
			// this will generage most of the object
			return group.toForemanObject();
			
		}
	}
}