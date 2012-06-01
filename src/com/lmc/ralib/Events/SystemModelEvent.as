
package com.lmc.ralib.Events
{
	import flash.events.Event;
	
	public class SystemModelEvent extends Event
	{	
		public static const ADD_REQUEST:String = 'SystemModelEvent.addRequest';
		public static const SYSTEM_ADDED:String = 'SystemModelEvent.systemAdded';
		public static const SYSTEMS_CLEARED:String = 'SystemModelEvent.systemsCleared';
		
		private var _system:String;
		
		public function SystemModelEvent(type:String, system:String = null)
		{
			super(type);
			_system = system;
		}
		
		public function get system():String
		{
			return _system;
		}
		override public function clone():Event{
			return new SystemModelEvent(type, system);
		}
	
	}
}