package com.lmc.ralib.Events
{
	import flash.events.Event;
	
	public class SearchEvent extends Event
	{
		public static const FIND_HOSTS_BY_GROUP:String = "SearchEvent.findhostsbygroup";
		private var _hostgroup:String;
		private var _hostgroups:Vector.<Object>;

		public function SearchEvent(type:String, hostgroup:String=null, hostgroups:Vector.<Object>=null,
									bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_hostgroup = hostgroup;
			_hostgroups = hostgroups;

		}
		public function get hostgroup():String{
			return _hostgroup;
		}
		public function get hostgroups():Vector.<Object>{
			return _hostgroups;
		}
		public override function clone():Event{
			return new SearchEvent(type, hostgroup, hostgroups);
		}
	}
}