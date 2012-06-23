package com.lmc.ralib.controller.classes
{
	import com.lmc.ralib.Events.DataCorrelationEvent;
	import com.lmc.ralib.model.HostGroup;
	import com.lmc.ralib.model.HostGroups;
	import com.lmc.ralib.model.Hosts;
	import com.lmc.ralib.model.PuppetClass;
	import com.lmc.ralib.model.PuppetClasses;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	import org.robotlegs.mvcs.Command;
	
	public class JoinGroupClasseswithAllClassesCommand extends Command
	{
		[Inject] public var classes:PuppetClasses;
		[Inject] public var event:DataCorrelationEvent;
		[Inject] public var hostgroups:HostGroups;
		private var combined:ArrayCollection = new ArrayCollection();
		private var chash:Dictionary = new Dictionary();

		public function JoinGroupClasseswithAllClassesCommand()
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
			// find parent
			var parent:HostGroup;
			if (event.hostgroup.ancestry != null){
				parent = hostgroups.findbyid(event.hostgroup.ancestry);
			}
			for each (var item:PuppetClass in event.hostgroup.puppetclasses.values){
					
					var obj:Object = new Object();
					obj.name = item.name as String;
					
					if (parent){
						var pclass:PuppetClass = parent.puppetclasses.findbyname(item.name);
						obj.candeselect = (pclass == null);
						obj.groupname = parent.name;
						obj.hasparent = (pclass != null);
						obj.groupname = parent.name;
					}
					else{
						obj.candeselect = true;
						obj.hasparent = false;

					}
					obj.id = item.id;
					//obj.Description = "Description";
					obj.Status = true;
					obj.selected = true;
					chash[obj.name] = obj;
					combined.addItem(obj);
			}
			
		// lets add the rest of the modules that are not assigned
		// first lets find duplicates then add
			for each (var item2:Object in classes.values){
			// is this a duplicate?, lets check the hash first
				if (! chash[item2.name]){
					obj = new Object();
					obj.name = item2.name as String;
					obj.id = item2.id;
					obj.groupname = "";
					//obj.Description = "Description";
					obj.Status = false;
					obj.candeselect = true;
					obj.hasparent = false;
					obj.selected = false;
					combined.addItem(obj);
					chash[obj.name] = obj;
				}
			}
			sort(combined);
			dispatch(new DataCorrelationEvent(DataCorrelationEvent.COMBINED_CLASSES_WITH_GROUP_RESULT,null, combined));
			
		}
			
		
	}
	
}