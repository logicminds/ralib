package com.lmc.ralib.Events
{
	import com.lmc.ralib.model.Host;
	
	import flash.events.Event;
	
	public class HostPropertiesEvent extends Event
	{
		public static const GETPROPERTIES:String = "HostPropertiesEvent.getproperties";
		public static const GETPROPERTIESRESULT:String = "HostPropertiesEvent.getpropertiesresult";
		private var _host:Host;
		public function HostPropertiesEvent(type:String, host:Host,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_host = host;
		}
		public function get host():Host{
			return _host;
			
		}
		public override function clone():Event{
			return new HostPropertiesEvent(type, host);
		}
	}
}