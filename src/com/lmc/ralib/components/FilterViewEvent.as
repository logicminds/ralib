package com.lmc.ralib.components
{
	import flash.events.Event;
	
	public class FilterViewEvent extends Event
	{
		public static const SET_ITEMS:String = "com.lmc.ralib.components.FilterViewEvent.setitems";
		public static const GET_ITEMS_REQUEST:String = "com.lmc.ralib.components.FilterViewEvent.getitemsrequest";
		public static const GET_ITEMS_RESULT:String = "com.lmc.ralib.components.FilterViewEvent.getitemsresult";
		
		private var _selected:*;
		public function FilterViewEvent(type:String, selected:*=null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_selected = selected;
		}
		public function get selected():*{
			return _selected;
		}
		public override function clone():Event{
			return new FilterViewEvent(type,selected);
		}
	}
}