package com.lmc.ralib.model
{
	
	
	import mx.collections.ArrayCollection;
	
	public class Hosts extends baseCollection
	{
		public function Hosts(jsonObject:Object=null)
		{
			super(jsonObject);
			
		}
		public override function copy(jsonObject:Object):Boolean{
			var host:Host;
			for each (var obj:Object in jsonObject){
				host = new Host(obj);
				values.addItem(host);
				namehash[host.name] = host;
				
			}
			sort();
			return true;
		}
	
	}
}