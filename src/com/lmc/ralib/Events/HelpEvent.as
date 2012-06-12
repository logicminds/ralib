package com.lmc.ralib.Events
{
	import flash.events.Event;
	
	public class HelpEvent extends Event
	{
		public static const OPENHELP:String = "HelpEvent.openhelp";
		private var _message:String;
		private var _title:String;
		private var _link:String;
		
		public function HelpEvent(type:String, message:String, title:String, link:String,   bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_message = message;
			_title = title;
			_link = link;
		}
		public function get message():String{
			return _message;
		}
		public function get title():String{
			return _title;
		}
		public function get link():String{
			return _link;
		}
		public override function clone():Event{
			return new HelpEvent(type, message, title, link);
		}
	}
}