package com.lmc.ralib.model
{
	import com.lmc.ralib.model.*;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;

	public class HostGroups extends baseCollection
	{
			public function HostGroups(jsonObject:Object=null)
			{
				super(jsonObject, "hostsgroups");
				
			}
		public override function copy(jsonObject:Object):Boolean{
				for each (var obj:Object in jsonObject){
					for each (var entity:Object in obj){
						// this extra loop strips off the type so object.typeobject
						var group:HostGroup = new HostGroup(entity);
						values.addItem(group);
						namehash[group.name] = group;
						idhash[group.id.toString()] = group;
					}
				}
				sort();
				return true;
		}
		
		
	}
		
		
}
