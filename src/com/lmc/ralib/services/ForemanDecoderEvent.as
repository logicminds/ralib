package com.lmc.ralib.services
{
	import flash.events.Event;
	
	public class ForemanDecoderEvent extends Event
	{
		public static const HOSTS:String             = "ForemanDecoderEvent0001";
		public static const PUPPETCLASSES:String     = "ForemanDecoderEvent0002";
		public static const HOST:String              = "ForemanDecoderEvent0003";
		public static const HOSTGROUPS:String        = "ForemanDecoderEvent0004";
		public static const FACTVALUES:String        = "ForemanDecoderEvent0005";
		public static const FACTS:String             = "ForemanDecoderEvent0006";
		public static const HOSTGROUP:String		   = "ForemanDecoderEvent0007";
		public static const STATUS:String            = "ForemanDecoderEvent0008";
		public static const REPORTS:String           = "ForemanDecoderEvent0009";
		public static const REPORT:String            = "ForemanDecoderEvent0010";
		public static const HOSTFACTS:String         = "ForemanDecoderEvent0011";
		public static const PROXYLIST:String         = "ForemanDecoderEvent0012";
		public static const PROXYINFO:String         = "ForemanDecoderEvent0013";
		
		
		
		private var _data:*;
		
		public function ForemanDecoderEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}
		public function get data():*{
			return _data;
		}
			
		
	}
}