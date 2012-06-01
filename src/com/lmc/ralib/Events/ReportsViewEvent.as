package com.lmc.ralib.Events
{
	import com.lmc.ralib.model.ReportModel;
	
	import flash.events.Event;
	
	public class ReportsViewEvent extends Event
	{
		private var _query:String;
		private var _resourceid:int;
		private var _page:int;
		private var _usecache:Boolean;
		private var _report:ReportModel;
		private var _data:*;
		
		public static const QUERYEVENT:String = 'ReportsViewEvent.queryevent';
		public static const LOADMORE:String = 'ReportsViewEvent.loadmore';
		public static const REFRESH:String = 'ReportsViewEvent.refresh';
		public static const PARSE_REPORT:String = "com.lmc.ralib.Events.ReportsViewEvent.parsereport";
		public static const PARSE_REPORT_RESULT:String = "com.lmc.ralib.Events.ReportsViewEvent.parsereportresult";

		public function ReportsViewEvent(type:String, query:String=null, resourceid:int=-1, page:int=1, usecache:Boolean=false, report:ReportModel=null,
										 data:*=null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_usecache = usecache;
			_query = query;
			_resourceid = resourceid;
			_page = page;
			_report = report;
			_data = data;
		}
		public function get data():*{
			return _data;
		}
		public function get report():ReportModel{
			return _report;
		}
		public function get usecache():Boolean{
			return _usecache;
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
			return new ReportsViewEvent(type, query, resourceid, page, usecache, report, data);
		}

	}
}