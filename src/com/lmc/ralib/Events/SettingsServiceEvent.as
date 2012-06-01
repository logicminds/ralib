package com.lmc.ralib.Events
{
	import com.lmc.ralib.model.ProfilesModel;
	
	import flash.events.Event;
	
	public class SettingsServiceEvent extends Event
	{
		public static const WRITE_SUCCESS:String = "SettingsServiceEvent.writesuccess";
		public static const WRITE_FAILURE:String = "SettingsServiceEvent.writefailure";
		public static const WRITE_REQUEST:String = "SettingsServiceEvent.writerequest";
		public static const RESULT:String = "SettingsServiceEvent.result";
		public static const READ_REQUEST:String = 'SettingsServiceEvent.readrequest';
		public static const ZERO_RESULTS:String = 'SettingsServiceEvent.zeroresults';
		
		
		private var _newdata:*;
		private var _dataname:String;
		
		public function SettingsServiceEvent(type:String, dataname:String=null, newdata:*=null, 
										  bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_newdata = newdata;
			_dataname = dataname;
		}
		public function get newdata():*{
			return _newdata;
		}
		public function get dataname():String{
			return _dataname;
		}
	
		override public function clone():Event{
			return new SettingsServiceEvent(type, dataname, newdata);
		}
	}
}