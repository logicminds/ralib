package com.lmc.ralib.Events
{
	import flash.events.Event;
	
	public class ClientWriteRequestEvent extends Event
	{
		
		public static const CREATE_HOSTGROUP:String	 = "ClientWriteRequestEvent.create_hostgroup";
		private var _data:*;

		
		public function ClientWriteRequestEvent(type:String, data:*, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}
		public function get data():*{
			return _data;
		}
		override public function clone():Event{
			return new ClientWriteRequestEvent(type, data );
		}
	}
}