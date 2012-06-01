package com.lmc.ralib.Events
{
	import flash.events.Event;
	
	public class MenuEvent extends Event
	{
		public static const GET_HOST_MENU:String = "MenuEvent.gethostmenu";
		public static const RESULT_HOST_MENU:String = "MenuEvent.resulthostmenu";
		public static const GET_FACT_MENU:String = "MenuEvent.getfactmenu";
		public static const RESULT_FACT_MENU:String = "MenuEvent.resultfactmenu";
		private var _data:*;
		public function MenuEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}
		public function get data():*{
			return _data;
		}
		override public function clone():Event{
			return new MenuEvent(type, data);
		}
	}
}