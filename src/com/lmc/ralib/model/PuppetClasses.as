package com.lmc.ralib.model
{
    import flash.utils.Dictionary;
    
    import mx.collections.ArrayCollection;
    import mx.utils.ObjectUtil;
    
    import spark.collections.SortField;
    import spark.modules.Module;

	public class PuppetClasses extends baseCollection
	{
		
		public function PuppetClasses(jsonObject:Object=null)
		{
			super(jsonObject);
		}
		public override function copy(jsonObject:Object):Boolean{
			// this is the data module we need to work with
			//{"ulimits":[{"puppetclass":{"name":"ulimits","id":56}}]
			if (jsonObject){
				var id:int;
				var name:String;
				var module:Object = ObjectUtil.getClassInfo(jsonObject);
				var modulename:String;
				var numitems:int = module.properties.length;
				var i:int=0;
				for each (var p:Array in jsonObject) {
					i++;
					modulename = module.properties[numitems - i].toString();
					for each (var subp:Object in p){
						this.addjsonItem(subp.puppetclass);
					}
					
				}
				
			}
			sort();
			return true;
		}
		
		public function addjsonItem(item:*):void{
			//"classes":[{"puppetclass":{"name":"bind","lookup_keys":[],"id":56}},
			//{"puppetclass":{"name":"timesync","lookup_keys":[],"id":45}},
			//{"puppetclass":{"name":"weblogic","lookup_keys":[],"id":55}}]
			if (item){
				var puppetclass:PuppetClass = new PuppetClass();
				puppetclass.name = item.name;
				puppetclass.id = item.id;
				values.addItem(puppetclass);
				namehash[puppetclass.name] = puppetclass;
				idhash[puppetclass.id] = puppetclass;
			}
		}
			
		
	}
}
				
				