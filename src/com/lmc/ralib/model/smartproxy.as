package com.lmc.ralib.model
{
	public class smartproxy extends Object
	{
		
		/*[{"smart_proxy":{"name":"puppet",
			"created_at":"2011-06-23T06:52:48Z",
			"updated_at":"2011-06-23T06:52:48Z",
			"url":"http://puppet:8443","id":1}}] */
		
		public var name:String = "";
		public var created:String = "";
		public var updated:String = "";
		public var url:String = "";
		public var id:int = 0;
		
		public function smartproxy(sp:Object=null)
		{
			super();
			if (sp){
				copy(sp);
			}
			
		}
		public function copy(sp:Object):void{
			this.name = sp.name;
			this.created = sp.created_at;
			this.updated = sp.updated_at;
			this.url = sp.url;
			this.id = sp.id;
			
		}
	}
}