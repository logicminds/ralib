package com.lmc.ralib.Events
{
	import flash.events.Event;
	
	public class ClientResultEvent extends Event
	{
		public static const SUCCESS_RESULT:String    = "com.lmc.ralib.Events.ClientResultEvent.0014";
		public static const FAILED_RESULT:String     = "com.lmc.ralib.Events.ClientResultEvent.0015";
		public static const GROUP_HOSTS:String       = "com.lmc.ralib.Events.ClientResultEvent.grouphosts";
		public static const ACCESS_DENIED:String     = "com.lmc.ralib.Events.ClientResultEvent.0016";
		public static const HOSTS:String             = "com.lmc.ralib.Events.ClientResultEvent.0001";
		public static const PUPPETCLASSES:String     = "com.lmc.ralib.Events.ClientResultEvent.0002";
		public static const HOST:String              = "com.lmc.ralib.Events.ClientResultEvent.0003";
		public static const HOSTGROUPS:String        = "com.lmc.ralib.Events.ClientResultEvent.";
		public static const FACTVALUES:String        = "com.lmc.ralib.Events.ClientResultEvent.0005";
		public static const FACTS:String             = "com.lmc.ralib.Events.ClientResultEvent.0006";
		public static const HOSTGROUP:String		 = "com.lmc.ralib.Events.ClientResultEvent.0007";
		public static const STATUS:String            = "com.lmc.ralib.Events.ClientResultEvent.0008";
		public static const REPORTS:String           = "com.lmc.ralib.Events.ClientResultEvent.0009";
		public static const REPORT:String            = "com.lmc.ralib.Events.ClientResultEvent.0010";
		public static const HOSTFACTS:String         = "com.lmc.ralib.Events.ClientResultEvent.0011";
		public static const PROXYLIST:String         = "com.lmc.ralib.Events.ClientResultEvent.0012";
		public static const PROXYINFO:String         = "com.lmc.ralib.Events.ClientResultEvent.0013";
		public static const DASHBOARD:String		 = "com.lmc.ralib.Events.ClientResultEvent.0014";
		public static const UPDATE_HOSTGROUP:String  = "com.lmc.ralib.Events.ClientResultEvent.updatehostgroup";

		private var _data:*;
		
		
		public function ClientResultEvent(type:String, data:*=null, 
										   bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
			
			
		}
		public function get data():*{
			return _data;
		}
	
		override public function clone():Event{
			return new ClientResultEvent(type, data );
		}
		
	}
}