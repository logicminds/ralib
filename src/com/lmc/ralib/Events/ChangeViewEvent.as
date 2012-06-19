package com.lmc.ralib.Events
{
	import com.lmc.ralib.model.Bookmark;
	
	import flash.events.Event;
	
	import spark.components.View;
	
	public class ChangeViewEvent extends Event
	{
		public static const LOAD_VIEW:String = "ChangeViewEvent.loadview";
		
		private var _navid:int;
		private var _view:Class;
		private var _data:*;
		private var _bookmark:Bookmark;
		private var _query:String;
		
		public function ChangeViewEvent(type:String, view:Class, navid:int=0, data:*=null, bookmark:Bookmark=null, query:String=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_view = view;
			_data = data;
			_bookmark = bookmark;
			_query = query;
			_navid = navid;
			
		}
		public function get navid():int{
			return _navid;
		}
		public function get view():Class{
			return _view;
		}
		public function get data():*{
			return _data;
		}
		public function get bookmark():Bookmark{
			return _bookmark;
		}
		public function get query():String{
			return _query;
		}
		public override function clone():Event{
			return new ChangeViewEvent(type, view, navid, data, bookmark, query);
		}
	}
}