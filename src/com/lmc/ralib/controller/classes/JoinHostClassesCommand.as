package com.lmc.ralib.controller.classes
{
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.DataCorrelationEvent;
	import com.lmc.ralib.Events.RestClientEvent;
	import com.lmc.ralib.model.Host;
	import com.lmc.ralib.model.HostGroup;
	import com.lmc.ralib.model.HostGroups;
	import com.lmc.ralib.model.PuppetClass;
	import com.lmc.ralib.model.PuppetClasses;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	
	import org.robotlegs.mvcs.Command;
	
	import spark.collections.SortField;
	
	public class JoinHostClassesCommand extends Command
	{
		
		[Inject] public var event:DataCorrelationEvent;
		[Inject] public var groups:HostGroups;
		[Inject] public var classes:PuppetClasses;
		
		private var host:Host;
		public function JoinHostClassesCommand()
		{
			super();
		}
		public override function execute():void{
			trace("JoinHostClassesCommand was called");
			commandMap.detain(this);
			host = Host(event.data);
			
			//TODO all this work makes it very expensive to call, maybe find a way to cache this
			
			// get the host classes
			this.eventDispatcher.addEventListener(RestClientEvent.HOST_CLASSES, onHostClassesResult)
			dispatch(new ClientRequestEvent(ClientRequestEvent.HOST_CLASSES,false,host.name));		
			
		}
		private function sort(values:ArrayCollection,field:String="name"):void{
			var sortByName:SortField = new SortField(field);
			var sortBySelected:SortField = new SortField("selected",true,true);
			var sortobject:Sort = new Sort();
			if (!values.sort){
				// no need to recreate
				sortobject.fields = [ sortBySelected, sortByName];
				values.sort = sortobject;
			}
			values.refresh();
			
		}
		private function onHostClassesResult(event:RestClientEvent):void{
			trace("Host Classes Result was called");
			this.eventDispatcher.removeEventListener(RestClientEvent.HOST_CLASSES, onHostClassesResult)

			var combined:ArrayCollection = new ArrayCollection(); 
			var chash:Dictionary = new Dictionary(); 
			var parent:HostGroup;
			var obj:Object;
			var pclass:PuppetClass;
			var groupclasses:PuppetClasses;
			var hostclasses:PuppetClasses = PuppetClasses(event.data);
			trace("Host Classes:" + hostclasses.values.length);
			// find parent
			if (host.hostgroup_id > 0){
				parent = groups.findbyid(host.hostgroup_id.toString());
				groupclasses = parent.puppetclasses;
				trace("Group Classes:" + groupclasses.values.length);


			}
			if (groupclasses){
				for each (var item:PuppetClass in groupclasses.values){
					//users cannot modify these unless at the group level
					obj = new Object();
					obj.name = String(item.name);
					obj.candeselect = false;
					obj.hasparent = true;
					obj.groupname = parent.name;
					obj.id = item.id;
					obj.Description = "Description";
					obj.Status = true;
					obj.selected = true;
					chash[obj.name] = obj;
					//combined.addItem(obj);
				}
				/*
				pclass = parent.puppetclasses.findbyname(item.name);
				obj.candeselect = pclass == null;
				obj.groupname = parent.name;
				obj.hasparent = pclass == null;
				*/
				
			}
			if (hostclasses){
				for each (var hitem:PuppetClass in hostclasses.values){
					obj = new Object();
					obj.name = String(hitem.name);
					obj.candeselect = true;
					obj.hasparent = false;
					obj.id = hitem.id;
					obj.Description = "Description";
					obj.Status = true;
					obj.selected = true;
					chash[obj.name] = obj;
					//combined.addItem(obj);
				}
			}
				// lets add the rest of the modules that are not assigned
				// first lets find duplicates then add
			trace("Available Classes:" + classes.values.length);

			for each (var item2:Object in classes.values){
					// is this a duplicate?, lets check the hash first
					if (! chash[item2.name]){
						obj = new Object();
						obj.name = String(item2.name);
						obj.id = item2.id;
						obj.groupname = "";
						obj.Description = "Description";
						obj.Status = false;
						obj.candeselect = true;
						obj.hasparent = false;
						obj.selected = false;
						//combined.addItem(obj);
						chash[obj.name] = obj;
					}
			}
			// turn the hash into an arraycollection
			trace("Before Total Classes:" + combined.length);

			for each (var cobj:Object in chash){
				combined.addItem(cobj);
			}
			trace("After Total Classes:" + combined.length);
			
			sort(combined);
			commandMap.release(this);

			dispatch(new DataCorrelationEvent(DataCorrelationEvent.COMBINED_CLASSES_WITH_HOST_RESULT,null, combined));
			
		}
		
	}
}