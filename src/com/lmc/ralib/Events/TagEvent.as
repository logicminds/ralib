package com.lmc.ralib.Events
{
	import flash.events.Event;
	
	public class TagEvent extends Event
	{
		public var tagtype:String;
		public var taglabel:String;
		public function TagEvent(type:String, _taglabel:String, _tagtype:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			tagtype = _tagtype;
			taglabel = _taglabel;
		}
	}
}