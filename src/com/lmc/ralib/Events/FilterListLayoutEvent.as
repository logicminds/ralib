package com.lmc.ralib.Events
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class FilterListLayoutEvent extends Event
	{
		public static const OPEN:String = "FilterListLayoutEvent.open";
		public static const CLOSE:String = "FilterListLayoutEvent.close";
		public static const CHANGE:String = "FilterListLayoutEvent.change";
		private var _owner:DisplayObject;
		private var _data:*;
		public function FilterListLayoutEvent(type:String, data:*=null, owner:DisplayObject=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
			_owner = owner;
		}
		public function get data():*{
			return _data;
		}
		public function get owner():DisplayObject{
			return _owner;
		}
		public override function clone():Event{
			return new FilterListLayoutEvent(type, data, owner);
			
		}
		
	}
}