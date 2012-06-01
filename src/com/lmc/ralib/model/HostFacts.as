package com.lmc.ralib.model
{
	import mx.collections.ArrayCollection;

	public class HostFacts extends baseCollection
	{
		public function HostFacts(jsonObject:Object=null)
		{
			super(jsonObject, "Facts");
			
		}
	/*	public override function copy(jsonObject:Object):Boolean{
			for each (var obj:Object in jsonObject){
				values.addItem({name:obj.fact_name.name});
				namehash[obj.fact_name.name] = obj;
				
			}
			return true;
		}
		*/
		public override function copy(jsonObject:Object):Boolean{
			var value:Object;
			var factobj:Object;
			var obj:Object;
			for (var key:Object in jsonObject){
				factobj = jsonObject[key] as Object;
				for (var factkey:Object in factobj){
					//factname = ObjectUtil.getClassInfo(factkey).properties[0];
					value = factobj[factkey].toString();
					values.addItem({name: factkey, value: value});
					namehash[factkey] = value;
				}
				
			}
			sort("name", false);
			return true;
		}
	}
}