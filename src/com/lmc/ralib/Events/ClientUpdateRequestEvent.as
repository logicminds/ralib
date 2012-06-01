package com.lmc.ralib.Events
{
	import flash.events.Event;
	
	public class ClientUpdateRequestEvent extends Event
	{
		public static const REQUEST:String = "com.lmc.ralib.Events.ClientUpdateRequestEvent.request";
		public static const SEARCH_HOSTS:String = "com.lmc.ralib.Events.ClientUpdateRequestEvent.searchhosts";
		public static const HOSTS:String             = "com.lmc.ralib.Events.ClientUpdateRequestEvent.20001";
		public static const PUPPETCLASSES:String     = "com.lmc.ralib.Events.ClientUpdateRequestEvent.20002";
		public static const HOST:String              = "com.lmc.ralib.Events.ClientUpdateRequestEvent.20003";
		public static const HOSTGROUPS:String        = "com.lmc.ralib.Events.ClientUpdateRequestEvent.20004";
		public static const FACTVALUES:String        = "com.lmc.ralib.Events.ClientUpdateRequestEvent.20005";
		public static const FACTS:String             = "com.lmc.ralib.Events.ClientUpdateRequestEvent.20006";
		public static const STATUS:String            = "com.lmc.ralib.Events.ClientUpdateRequestEvent.20008";
		public static const REPORTS:String           = "com.lmc.ralib.Events.ClientUpdateRequestEvent.20009";
		public static const REPORT:String            = "com.lmc.ralib.Events.ClientUpdateRequestEvent.20010";
		public static const HOSTFACTS:String         = "com.lmc.ralib.Events.ClientUpdateRequestEvent.20011";
		public static const PROXYLIST:String         = "com.lmc.ralib.Events.ClientUpdateRequestEvent.20012";
		public static const PROXYINFO:String         = "com.lmc.ralib.Events.ClientUpdateRequestEvent.20013";
		public static const DASHBORAD:String         = "com.lmc.ralib.Events.ClientUpdateRequestEvent.20014";
		public static const HOSTGROUP:String  = "com.lmc.ralib.Events.ClientUpdateRequestEvent.hostgroup";
		public static const MULTIPLE_HOSTGROUP:String = "com.lmc.ralib.Events.ClientUpdateRequestEvent.multiplehostgroup";
		
		private var _resourceid:int;
		private var _data:*;
		private var _selected:*;
		private var _unselected:*;
		public function ClientUpdateRequestEvent(type:String,data:*=null, selected:*=null, unselected:*=null,
										      resourceid:int=-1, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_selected = selected;
			_unselected = unselected;
			_resourceid = resourceid;
			_data = data;
			
		}
		public function get selected():*{
			return _selected;
		}
		public function get unselected():*{
			return _unselected;
		}
		public function get data():*{
			return _data;
		}
	
		public function get resourceid():int{
			return _resourceid;
		}
		
		override public function clone():Event{
			return new ClientUpdateRequestEvent(type, data, selected, unselected, resourceid );
		}
	}
}