package com.lmc.ralib.Events
{
	import flash.events.Event;
	
	public class GroupFormEvent extends Event
	{
		public static const SAVED_CLICKED:String = "com.lmc.ralib.components.GroupFormEvent.savedclicked";
		public static const RESULT:String = "com.lmc.ralib.components.GroupFormEvent.savedclicked.result";

		private var _data:Object;
		private var _result:Boolean;
		public function GroupFormEvent(type:String, data:Object=null, result:Boolean=false, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
			_result = result;
		}
		public function get data():Object{
			return _data;
		}
		public function get result():Boolean{
			return _result;
		}
	}
}