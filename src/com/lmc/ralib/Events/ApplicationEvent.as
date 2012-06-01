package com.lmc.ralib.Events
{
	import flash.events.Event;
	
	
	public class ApplicationEvent extends Event
	{
		public static const STARTUP_COMMAND_COMPLETE:String = "com.lmc.ralib.Events.ApplicationEvent.startupcommandcomplete";
		public static const SHOW_EULA:String = "com.lmc.ralib.Events.ApplicationEvent.show_eula";
		public static const CLOSE_EULA:String = "com.lmc.ralib.Events.ApplicationEvent.close_eula";
		public static const LOAD_FIRST_VIEW:String = "com.lmc.ralib.Events.ApplicationEvent.loadfirstview";
		public static const CLEAR_CACHE_REQUEST:String = "com.lmc.ralib.Events.ApplicationEvent.clearcacherequest";
		public static const CLEAR_CACHE_RESULT:String = "com.lmc.ralib.Events.ApplicationEvent.clearcacheresult";

		private var _firstview:Class;
		private var _data:*;
		private var _navtabindex:int;
		public function ApplicationEvent(type:String, firstview:Class=null,data:*=null, navtabindex:int=0, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_firstview = firstview;
			_data = data;
			_navtabindex = navtabindex;
			
		}
		public function get firstview():Class{
			return _firstview;
		}
		public function get navtabindex():int{
			return _navtabindex;
		}
		public function get data():*{
			return data;
		}
		override public function clone():Event{
			return new ApplicationEvent(type, firstview, data, navtabindex);
		}
	}
}