package com.lmc.ralib.model
{
	import mx.collections.ArrayCollection;

	public class Facts extends baseCollection
	{
		public function Facts(jsonObject:Object=null)
		{
			super(jsonObject);
			
		}
		public override function copy(jsonObject:Object):Boolean{
			for each (var obj:Object in jsonObject){
				values.addItem({name:obj.fact_name.name});
				namehash[obj.fact_name.name] = obj;
				
			}
			sort();
			return true;
		}
		
	}
}