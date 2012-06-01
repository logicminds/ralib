package com.lmc.ralib.Events
{
	import com.lmc.ralib.model.HostGroup;
	
	import flash.events.Event;
	
	public class DataCorrelationEvent extends Event
	{
		public static const HOSTS_WITH_HOSTGROUP_REQUEST:String = "com.lmc.ralib.Events.DataCorrelationEvent.hostswithhostgrouprequest";
		public static const HOSTS_WITH_HOSTGROUP_RESULT:String = "com.lmc.ralib.Events.DataCorrelationEvent.hostswithhostgroupresult";
		public static const COMBINED_CLASSES_WITH_GROUP_REQUEST:String = "com.lmc.ralib.Events.DataCorrelationEvent.combinedclasseswithgrouprequest";
		public static const COMBINED_CLASSES_WITH_GROUP_RESULT:String = "com.lmc.ralib.Events.DataCorrelationEvent.combinedclasseswithgroupresult";
		public static const COMBINED_CLASSES_WITH_HOST_REQUEST:String = "com.lmc.ralib.Events.DataCorrelationEvent.combinedclasseswithhostrequest";
		public static const COMBINED_CLASSES_WITH_HOST_RESULT:String = "com.lmc.ralib.Events.DataCorrelationEvent.combinedclasseswithhostresult";


		private var _name:String;
		private var _items:*;
		private var _hostgroup:HostGroup;
		private var _data:*;
		
		public function DataCorrelationEvent(type:String, name:String=null, items:*=null, hostgroup:HostGroup=null,
											 data:*=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_name = name;
			_items = items;
			_hostgroup = hostgroup;
			_data = data;

		}
		public function get data():*{
			return _data;
		}
		public function get name():String{
			return _name;
		}
		public function get hostgroup():HostGroup{
			return _hostgroup;
		}
		public function get items():*{
			return _items;
		}
		public override function clone():Event{
			return new DataCorrelationEvent(type, name, items, hostgroup, data);
		}
	}
}