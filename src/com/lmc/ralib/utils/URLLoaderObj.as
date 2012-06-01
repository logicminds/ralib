package com.lmc.ralib.utils
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.utils.UIDUtil;
	
	public class URLLoaderObj extends URLLoader
	{
		public var id:String = UIDUtil.createUID();

		public function URLLoaderObj(request:URLRequest=null)
		{
			super(request);
		}
	}
}