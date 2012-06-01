package com.lmc.ralib.Events
{
	import flash.events.Event;
	
	public class ClientWriteResultEvent extends Event
	{
		public static const HOSTGROUP_CREATED:String	 = "ClientWriteResultEvent.created_hostgroup";
		private var _data:*;
		private var _result:Boolean;
		public function ClientWriteResultEvent(type:String, result:Boolean=false, data:*=null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
			_result = result;
		}
		public function get data():*{
			return _data;
			
		}
		public function get result():Boolean{
			return _result;
		}
		override public function clone():Event{
			return new ClientWriteResultEvent(type, result, data );
		}
	}
}