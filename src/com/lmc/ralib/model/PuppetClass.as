package com.lmc.ralib.model
{
	public class PuppetClass extends baseModel
	{
		
		public var modulename:String;
		public function PuppetClass(jsonObject:Object=null)
		{
			super("PuppetClass", jsonObject);
		}
		public override function copy(jsonObject:Object):void{
			if (jsonObject){
				id = jsonObject.id;
				name = jsonObject.name;
				modulename = jsonObject.modulename
			}
		}
		/*public function toJSON():String{
			
			// "{"puppetclass":{"name":"memcache","lookup_keys":[],"id":18}}"
			return "";
			
		}
		*/
	}
}