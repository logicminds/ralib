package com.lmc.ralib.Events
{
	import flash.events.Event;
	
	public class LicenseEvent extends Event
	{
		public static const OPEN:String = 'LicenseEvent.open';
		public static const RESULT:String = 'LicenseEvent.result';
		public static const RESPONSE:String = 'LicenseEvent.response';
		public static const DENY:String = 'LicenseEvent.deny';

		private var _accepted:Boolean;
		public function LicenseEvent(type:String, accepted:Boolean=false, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_accepted = accepted;
			
		}
		public function get accepted():Boolean{
			return _accepted;
		}
		public override function clone():Event{
			return new LicenseEvent(type, accepted);
		}
	}
}