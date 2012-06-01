package com.lmc.ralib.Events
{
	import flash.events.Event;
	
	public class AnalyticsTrackerEvent extends Event
	{
		public static const TRACKPAGEVEW:String = "AnalyticsTrackerEvent.trackpageview";
		private var _page:String;
		public function AnalyticsTrackerEvent(type:String, page:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_page = page;
		}
		public function get page():String{
			return _page;
		}
		public override function clone():Event{
			return new AnalyticsTrackerEvent(type, page);
		}
	}
}