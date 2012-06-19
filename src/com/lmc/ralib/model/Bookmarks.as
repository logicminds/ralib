package com.lmc.ralib.model
{
	public class Bookmarks extends baseCollection
	{
		public function Bookmarks(jsonObject:Object=null, type:String=null)
		{
			super(jsonObject, type);
			
		}
		public function add(bookmark:Bookmark):void{
			values.addItem(bookmark);
			namehash[bookmark.name] = bookmark;
			idhash[bookmark.id] =  bookmark;

			
		}
		public override function copy(jsonObject:Object):Boolean{
			for each (var bookmark:Object in jsonObject){
				this.add(new Bookmark(null,bookmark.bookmark));
			}
			return true;
		}
		
		/*[{"bookmark":{"name":"active","public":true,"id":2,"owner_id":1,"controller":"hosts","owner_type":"User",
		"query":"last_report > \"35 minutes ago\" and (status.applied > 0 or status.restarted > 0)"}},
		
		{"bookmark":{"name":"disabled","public":true,"id":5,"owner_id":1,"controller":"hosts","owner_type":"User",
		"query":"status.enabled = false"}},
		
		{"bookmark":{"name":"error","public":true,"id":4,"owner_id":1,"controller":"hosts","owner_type":"User",
		"query":"last_report > \"35 minutes ago\" and (status.failed > 0 or status.failed_restarts > 0 or status.skipped > 0)"}},
		
		{"bookmark":{"name":"eventful","public":true,"id":1,"owner_id":1,"controller":"reports","owner_type":"User",
		"query":"eventful = true"}},
		
		{"bookmark":{"name":"out of sync","public":true,"id":3,"owner_id":1,"controller":"hosts","owner_type":"User",
		"query":"last_report < \"30 minutes ago\" and status.enabled = true"}}]
		*/
	}
}