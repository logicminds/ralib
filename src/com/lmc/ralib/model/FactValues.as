package com.lmc.ralib.model
{
	import com.lmc.ralib.model.FactValues;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectUtil;
	
	import spark.modules.Module;
	
	public class FactValues extends baseModel
	{
		[Bindable] private var _filteredvalues:ArrayCollection;
		private var _grouplist:Dictionary;
		private var _factvalues:Object;
		
		public function FactValues(jsonObject:Object=null, grouplist:Dictionary=null)
		{
			//obj.hostname.value
			_filteredvalues = new ArrayCollection();
			_grouplist = grouplist;
			_factvalues = jsonObject;
			trace('Fact json object, ' + jsonObject);
			super("FactValues", jsonObject);
			
		}
		public function get factvalues():Object{
			return _factvalues;
		}
		public function get grouplist():Dictionary{
			return _grouplist;
		}
		public function get values():ArrayCollection{
			return _filteredvalues;
		}
		public function set grouplist(list:Dictionary):void{
			_grouplist = list;
			filter();
		}
		public function set factvalues(jsonObject:Object):void{
			_factvalues = jsonObject;
			filter();
		}
		public function filter():void{
			_filteredvalues.removeAll();
			copy(_factvalues);
		}
		public override function copy(jsonObject:Object):void{
			if (jsonObject){
				var counthash:Dictionary = new Dictionary();
				var hosthash:Dictionary = new Dictionary();
				var hostname:String;
				var factname:String;
				var value:Object;
				var hostarray:ArrayCollection;
				var factobj:Object;
				var aobj:Object;
				
				for (var key:Object in jsonObject){
					hostname = key.toString();
					if (_grouplist != null){
						// the grouplist acts as an filter for groups
						if ( ! _grouplist[hostname] ){
							// if the host is not in the group then skip
							continue;
						}
					}
					factobj = jsonObject[key] as Object;
					factname = ObjectUtil.getClassInfo(factobj).properties[0];
					value = factobj[factname].toString();
					if (counthash[value] != null){
						// fact already exists, lets increment the counter
						counthash[value] += 1;
						hostarray = hosthash[value];
						hostarray.addItem(hostname);
					}
					else{
						// fact doesn't exist create new entry in hash
						counthash[value] = 1;
						// create new array to put hosts in
						hostarray = new ArrayCollection();
						hostarray.addItem(hostname);
						hosthash[value] = hostarray;
					}
				}
				// put hash tables in the array
				for (var key2:* in counthash){
					aobj = {hosts:hosthash[key2], value:key2, count: counthash[key2]};
					_filteredvalues.addItem(aobj);
				}
				
			}
		}
		public function deepcopy(obj:FactValues):void{
			_grouplist = obj.grouplist;
			_factvalues = obj.factvalues;
			values.source = obj.values.source;
			values.refresh();
		}
	
		
		
	}
}