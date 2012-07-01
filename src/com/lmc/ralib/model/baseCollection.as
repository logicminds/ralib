package com.lmc.ralib.model
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	import org.robotlegs.mvcs.Actor;

	public class baseCollection extends Actor
	{
		[Bindable] private var _values:ArrayCollection;
		public var name:String;
		public var id:int;
		public var sortobject:Sort = new Sort();
		public var _type:String;
		public var namehash:Dictionary = new Dictionary();
		public var idhash:Dictionary = new Dictionary();
		public function baseCollection(jsonObject:Object)
		{
			
			_values = new ArrayCollection;
			super();
			
			if (jsonObject){
				copy(jsonObject);	
			}
		}
		public function removeAll():void{
			// this clears all the data
			values.removeAll();
			namehash = new Dictionary();
			idhash = new Dictionary();
			
		}
		public function get values():ArrayCollection{
			return _values;
		}
		public function set values(v:ArrayCollection):void{
			_values.source = v.source;
			_values.refresh();
		}
		public function addItem(item:*):void{
			_values.addItem(item);
			namehash[item.name] = item;
			idhash[item.id] = item;
		}
		public function cloneInto(newmodel:baseCollection):void{
			values.source = newmodel.values.source;
			namehash = newmodel.namehash;
			idhash = newmodel.idhash;
		}
		public function copy(jsonObject:Object):Boolean{
			
			for each (var obj:Object in jsonObject){
				for each (var entity:Object in obj){
					// this extra loop strips off the type so object.typeobject
					_values.addItem(entity);
					namehash[entity.name] = entity;
					idhash[entity.id] = entity;
				}
				
			}
			return true;
		}
		public function sort(field:String="name", dsc:Boolean=true):void{
			if (!values.sort){
				// no need to recreate
				sortobject.fields = [ new SortField(field, false,dsc) ];
				values.sort = sortobject;
			}
			values.refresh();

		}
		public function findbyname(name:String):*{
			return namehash[name];
		}
		public function findbyid(id:String):*{
			return idhash[id]
		}
		
	}
	
}