package com.lmc.ralib.Events
{
	import flash.events.Event;
	
	public class ClientUpdateResultEvent extends Event
	{
		public static const REQUEST:String = "com.lmc.ralib.Events.ClientUpdateResultEvent.result";
		public static const SEARCH_HOSTS:String = "com.lmc.ralib.Events.ClientUpdateResultEvent.searchhosts";
		public static const HOSTS:String             = "com.lmc.ralib.Events.ClientUpdateResultEvent.20001";
		public static const PUPPETCLASSES:String     = "com.lmc.ralib.Events.ClientUpdateResultEvent.20002";
		public static const HOST:String              = "com.lmc.ralib.Events.ClientUpdateResultEvent.20003";
		public static const HOSTGROUPS:String        = "com.lmc.ralib.Events.ClientUpdateResultEvent.20004";
		public static const FACTVALUES:String        = "com.lmc.ralib.Events.ClientUpdateResultEvent.20005";
		public static const FACTS:String             = "com.lmc.ralib.Events.ClientUpdateResultEvent.20006";
		public static const STATUS:String            = "com.lmc.ralib.Events.ClientUpdateResultEvent.20008";
		public static const REPORTS:String           = "com.lmc.ralib.Events.ClientUpdateResultEvent.20009";
		public static const REPORT:String            = "com.lmc.ralib.Events.ClientUpdateResultEvent.20010";
		public static const HOSTFACTS:String         = "com.lmc.ralib.Events.ClientUpdateResultEvent.20011";
		public static const PROXYLIST:String         = "com.lmc.ralib.Events.ClientUpdateResultEvent.20012";
		public static const PROXYINFO:String         = "com.lmc.ralib.Events.ClientUpdateResultEvent.20013";
		public static const DASHBORAD:String         = "com.lmc.ralib.Events.ClientUpdateResultEvent.20014";
		public static const HOSTGROUP:String	     = "com.lmc.ralib.Events.ClientUpdateResultEvent.updatehostgroup";
		public static const MULTIPLE_HOSTGROUP:String = "com.lmc.ralib.Events.ClientUpdateResultEvent.multiplehostgroup";

		private var _resourceid:int;
		private var _data:*;
		private var _success:Boolean;
		public function ClientUpdateResultEvent(type:String, resourceid:int=-1, 
												 data:*=null, success:Boolean=false, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			_resourceid = resourceid;
			_data = data;
			_success = success;
			
		}
		public function get success():Boolean{
			return _success;
		}
		public function get data():*{
			return _data;
		}
		
		public function get resourceid():int{
			return _resourceid;
		}
		
		override public function clone():Event{
			return new ClientUpdateResultEvent(type, resourceid, data, success );
		}
	}
}