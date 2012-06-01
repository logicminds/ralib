package com.lmc.ralib.Events
{
	import com.lmc.ralib.model.ProfileModel;
	
	import flash.events.Event;
	
	public class ClientRequestEvent extends Event
	{
		public static const REQUEST:String = "ClientRequestEvent.request";
		public static const SEARCH_HOSTS:String = "ClientRequestEvent.searchhosts";
		public static const HOSTS:String             = "com.lmc.ralib.Events.ClientRequestEvent.20001";
		public static const GROUP_HOSTS:String       = "com.lmc.ralib.Events.ClientRequestEvent.grouphosts";
		public static const PUPPETCLASSES:String     = "com.lmc.ralib.Events.ClientRequestEvent.20002";
		public static const HOST:String              = "com.lmc.ralib.Events.ClientRequestEvent.host";
		public static const HOST_CLASSES:String      = "com.lmc.ralib.Events.ClientRequestEvent.hostclasses";
		public static const BOOKMARKS:String		= "com.lmc.ralib.services.ClientRequestEvent.bookmarks";

		public static const HOSTGROUPS:String        = "com.lmc.ralib.Events.ClientRequestEvent.hostgroups";
		public static const FACTVALUES:String        = "com.lmc.ralib.Events.ClientRequestEvent.20005";
		public static const FACTS:String             = "com.lmc.ralib.Events.ClientRequestEvent.20006";
		public static const HOSTGROUP:String		 = "com.lmc.ralib.Events.ClientRequestEvent.20007";
		public static const STATUS:String            = "com.lmc.ralib.Events.ClientRequestEvent.20008";
		public static const REPORTS:String           = "ClientRequestEvent.20009";
		public static const REPORT:String            = "com.lmc.ralib.Events.ClientRequestEvent.20010";
		public static const HOSTFACTS:String         = "com.lmc.ralib.Events.ClientRequestEvent.20011";
		public static const PROXYLIST:String         = "com.lmc.ralib.Events.ClientRequestEvent.20012";
		public static const PROXYINFO:String         = "com.lmc.ralib.Events.ClientRequestEvent.20013";
		public static const DASHBORAD:String         = "com.lmc.ralib.Events.ClientRequestEvent.20014";
		public static const UPDATE_HOSTGROUP:String  = "com.lmc.ralib.Events.ClientRequestEvent.updatehostgroup";
		
		private var _query:String;
		private var _resourceid:int;
		private var _page:int;
		private var _usecache:Boolean;
		private var _profile:ProfileModel;
		private var _data:*;
		public function ClientRequestEvent(type:String, usecache:Boolean=true, query:String=null, resourceid:int=-1, 
										   page:int=1,profile:ProfileModel=null, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_usecache = usecache;
			_query = query;
			_resourceid = resourceid;
			_page = page;
			_profile = profile;
			_data = data;
			
		}
		public function get data():*{
			return _data;
		}
		public function get usecache():Boolean{
			return _usecache;
		}
		public function get profile():ProfileModel{
			return _profile;
		}
		public function get query():String{
			return _query;
		}
		public function get resourceid():int{
			return _resourceid;
		}
		public function get page():int{
			return _page;
		}
		override public function clone():Event{
			return new ClientRequestEvent(type, usecache, query, resourceid, page, profile, data );
		}
	}
}