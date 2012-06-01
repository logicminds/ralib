package com.lmc.ralib.model
{
	public class Bookmark extends baseModel
	{
		/*{"bookmark":{"name":"active","public":true,"id":2,"owner_id":1,"controller":"hosts","owner_type":"User",
		"query":"last_report > \"35 minutes ago\" and (status.applied > 0 or status.restarted > 0)"}}, */
		
		public var query:String;
		public var ispublic:Boolean;
		public var owner_id:int;
		public var controller:String;
		public var owner_type:String;
		
		public function Bookmark(type:String, jsonObject:Object=null)
		{
			super(type, jsonObject);
			
		}
		public override function copy(jsonObject:Object):void{
			id = jsonObject.id;
			name = jsonObject.name;
			query = jsonObject.query;
			//ispublic = jsonObject.public;
			//owner_id = jsonObject.owner_id;
			controller = jsonObject.controller;
			//owner_type = jsonObject.owner_type;
		}
	}
}