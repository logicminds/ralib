package com.lmc.ralib.Events
{
	import flash.events.Event;
	import flash.media.StageWebView;
	
	public class StageWebViewEvent extends Event
	{
		public static const OPEN:String = "com.lmc.ralib.Events.stageWebViewEvent.open";
		public static const CLOSE:String = "com.lmc.ralib.Events.stageWebViewEvent.close";
		public static const DISPLAYED:String = "com.lmc.ralib.Events.stageWebViewEvent.displayed";

		
		private var _url:String;
		private var _stageweb:StageWebView;
		private var _title:String;
		public function StageWebViewEvent(type:String, url:String, title:String=null,stageweb:StageWebView=null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_url = url;
			_stageweb = stageweb;
			_title = title;
		}
		public function get url():String{
			return _url;
			
		}
		public function get title():String{
			return _title;
		}
		public function get stageweb():StageWebView{
			return _stageweb;
		}
		public override function clone():Event{
			return new StageWebViewEvent(type, url, title,stageweb);
		}
	}
}