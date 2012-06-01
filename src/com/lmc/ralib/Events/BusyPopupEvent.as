package com.lmc.ralib.Events
{
	import flash.events.Event;
	
	public class BusyPopupEvent extends Event
	{
		public static const OPEN:String = "BusyPopupEvent.open";
		public static const CLOSE:String = "BusyPopupEvent.close";
		public static const CLOSE_ATTEMPT:String = "BusyPopupEvent.closeattempt";

		private var _parent:*;
		private var _title:String;
		public function BusyPopupEvent(type:String, title:String="Loading", parent:*=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_parent = parent;
			_title = title;
		}
		public function get parent():*{
			return _parent;
		}
		public function get title():String{
			return _title;
		}
		override public function clone():Event{
			return new BusyPopupEvent(type, title, parent);
		}
	}
}