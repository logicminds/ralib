package com.lmc.ralib.controller.groups
{
	import com.lmc.ralib.Events.DataCorrelationEvent;
	import com.lmc.ralib.model.Host;
	import com.lmc.ralib.model.HostGroup;
	import com.lmc.ralib.model.HostGroups;
	import com.lmc.ralib.model.Hosts;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	import org.robotlegs.mvcs.Command;
	
	public class JoinHostListandGroupHostListCommand extends Command
	{
		[Inject] public var hosts:Hosts;
		[Inject] public var event:DataCorrelationEvent;
		[Inject] public var groups:HostGroups;
		private var combinedhosts:ArrayCollection = new ArrayCollection();

		public function JoinHostListandGroupHostListCommand()
		{
			super();
		}
		private function sort(values:ArrayCollection,field:String="name"):void{
			var sortByName:SortField = new SortField(field);
			var sortBySelected:SortField = new SortField("selected",true);
			var sortobject:Sort = new Sort();
			if (!values.sort){
				// no need to recreate
				sortobject.fields = [ sortBySelected, sortByName];
				values.sort = sortobject;
			}
			values.refresh();
			
		}
		public override function execute():void{
			var grouphosts:Hosts = event.items;
			var objhash:Object = new Object();
			
			if ( grouphosts){
				var obj:Object;
				
				for each (var item:Host in grouphosts.values){
					
					obj = new Object();
					obj.name = item.name;
					// do this 
					// we only needed to use findid before foreman ticket #827 as resolved
					//obj.id = this.findid(obj);
					obj.hasparent = false;
					obj.candeselect = true;
					//obj.Description = "Description";
					obj.Status = true;
					obj.type = "host";
					obj.selected = true;
					obj.hostgroup_id = item.hostgroup_id;
					obj.groupname = "";
					combinedhosts.addItem(obj);
					objhash[obj.name] = obj;
					
				}
			
			}
			// lets add the rest of the modules that are not assigned
			// first lets find duplicates then add
			for each (var item2:Host in hosts.values){
				// is this a duplicate?
				obj = new Object();
				obj.name = item2.name as String;
				//obj.id = "-1";
				//obj.Description = "Description";
				obj.Status = false;
				obj.type = "host";

				obj.candeselect = true;
				obj.hostgroup_id = item2.hostgroup_id;
				obj.hasparent = item2.hostgroup_id > 0;
				if (obj.hasparent){
					obj.groupname = (groups.findbyid(item2.hostgroup_id.toString()) as HostGroup).name;
				}

				obj.selected = false;
				if (!objhash[obj.name] ){
					// check the hash to ensure it doesn't already exist	
					combinedhosts.addItem(obj);
					objhash[obj.name] = obj;
					
				}
				
			}
			sort(combinedhosts);
			dispatch(new DataCorrelationEvent(DataCorrelationEvent.HOSTS_WITH_HOSTGROUP_RESULT, null,combinedhosts));
		}
	
		
	}
		
	
}