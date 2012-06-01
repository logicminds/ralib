package com.lmc.ralib.Events
{
	import com.pialabs.eskimo.controls.SkinnableAlert;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import mx.core.FlexGlobals;

	public class AlertEvent extends Event
	{
		public static const OPEN:String = 'AlertEvent.open';
		public static const CLOSE:String = 'AlertEvent.close';
		
		private var _message:String;
		private var _title:String
		private var _alerttype:int;
		
		public function get message():String
		{
			return _message;
		}
	
		public function get title():String{
			return _title;
		}
		public function get alerttype():int{
			return _alerttype;
		}
		public function AlertEvent(type:String, title:String="Alert", message:String=null, 
								   alerttype:int=SkinnableAlert.OK, bubbles:Boolean=false, cancelable:Boolean=false )
		{
			super(type);
			_message = message;
			_title = title;
			_alerttype = alerttype;
		}
		override public function clone():Event{
			return new AlertEvent(type, title, message, alerttype, bubbles, cancelable);
		}
	}
}