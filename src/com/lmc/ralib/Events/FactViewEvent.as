package com.lmc.ralib.Events
{
	import flash.events.Event;
	
	public class FactViewEvent extends Event
	{
		public static const FACTVALUES:String = "FactViewEvent.factvalues";
		public static const FILTERHOSTGROUPS:String = "FactViewEvent.filterhostgroups";
		public static const CREATE_FACT_EMAIL:String = "FactViewEvent.createfactemail";
		public static const CREATE_HOSTS_FACT_EMAIL:String = "FactViewEvent.createhostsfactemail";


		private var _data:*;
		private var _factname:String;
		private var _usecache:Boolean;
		private var _filter:Object;
		private var _hosts:Array;
		private var _factvalues:Array;
		private var _factvalue:String;
		public function FactViewEvent(type:String, data:*=null, factname:String=null, usecache:Boolean=true,filter:Object=null, hosts:Array=null, factvalue:String=null,factvalues:Array=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
			_factname = factname;
			_usecache = usecache;
			_filter = filter;
			_hosts = hosts;
			_factvalues = factvalues;
			_factvalue = factvalue;
		}
		public function get filter():Object{
			return _filter;
			
		}
		public function get factvalue():String{
			return _factvalue;
		}
		public function get hosts():Array{
			return _hosts;
		}
		public function get factvalues():Array{
			return _factvalues;
		}
		public function get data():*{
			return _data;
			
		}
		public function get factname():String{
			return _factname;
		}
		public function get usecache():Boolean{
			return _usecache;
		}
		public override function clone():Event{
			return new FactViewEvent(type, data, factname, usecache, filter, hosts, factvalue,factvalues);
		}
	}
}