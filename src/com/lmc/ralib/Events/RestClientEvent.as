package com.lmc.ralib.Events
{
	import flash.events.Event;
	
	import mx.rpc.xml.SchemaTypeRegistry;
	
	public class RestClientEvent extends Event
	{
		public static const SUCCESS_RESULT:String    = "com.lmc.ralib.services.RestClientEvent.10014";
		public static const ALREADY_CREATED:String    = "com.lmc.ralib.services.RestClientEvent.alreadycreated";
		public static const BOOKMARKS:String		= "com.lmc.ralib.services.RestClientEvent.bookmarks";
		public static const FAILED_RESULT:String     = "com.lmc.ralib.services.RestClientEvent.10015";
		public static const ACCESS_DENIED:String     = "com.lmc.ralib.services.RestClientEvent.10016";
		public static const MULTIPLE_HOSTS:String    = "com.lmc.ralib.services.RestClientEvent.multiplehosts";
		public static const GROUP_HOSTS:String       = "com.lmc.ralib.services.RestClientEvent.GroupHosts";
		public static const HOSTS:String             = "com.lmc.ralib.services.RestClientEvent.gethosts";
		public static const PUPPETCLASSES:String     = "com.lmc.ralib.services.RestClientEvent.puppetclasses";
		public static const HOST:String              = "com.lmc.ralib.services.RestClientEvent.gethost";
		public static const HOST_CLASSES:String      = "com.lmc.ralib.services.RestClientEvent.hostclasses";

		public static const HOSTGROUPS:String        = "com.lmc.ralib.services.RestClientEvent.10004";
		public static const FACTVALUES:String        = "com.lmc.ralib.services.RestClientEvent.factvalues";
		public static const FACTS:String             = "com.lmc.ralib.services.RestClientEvent.facts";
		public static const HOSTGROUP:String		 = "com.lmc.ralib.services.RestClientEvent.10007";
		public static const UPDATE_HOSTGROUP:String	 = "com.lmc.ralib.services.RestClientEvent.updatehostgroup";
		public static const UPDATE_HOST:String	 = "com.lmc.ralib.services.RestClientEvent.updatehost";

		public static const STATUS:String            = "com.lmc.ralib.services.RestClientEvent.10008";
		public static const REPORTS:String           = "com.lmc.ralib.services.RestClientEvent.10009";
		public static const REPORT:String            = "com.lmc.ralib.services.RestClientEvent.10010";
		public static const HOSTFACTS:String         = "com.lmc.ralib.services.RestClientEvent.10011";
		public static const PROXYLIST:String         = "com.lmc.ralib.services.RestClientEvent.10012";
		public static const PROXYINFO:String         = "com.lmc.ralib.services.RestClientEvent.10013";
		public static const DASHBOARD:String         = "com.lmc.ralib.services.RestClientEvent.10014";
		public static const CREATE_GROUP_RESULT:String = "com.lmc.ralib.services.RestClientEvent.creategroupresult";
		
		private var _data:*;
		private var _success:Boolean;
		private var _statuscode:int;
		private var _message:*;
		private var _serializedClass:Class;
		public function RestClientEvent(type:String, success:Boolean,data:*=null,  statuscode:int=-1, message:*=null, serializedClass:Class=null, 
										   bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_success = success;
			_data = data;
			_serializedClass = serializedClass;
			_statuscode = statuscode;
			_message = message;
		}
		public function get success():Boolean{
			return _success;
		}
		public function get data():*{
			return _data;
		}
		public function get serializedClass():Class{
			return _serializedClass;
		}
		public function get statuscode():int{
			return this._statuscode;
		}
		public function get message():*{
			return this._message;
		}
		override public function clone():Event{
			return new RestClientEvent(type, success,data, statuscode, message, serializedClass);
		}
		
	}
}