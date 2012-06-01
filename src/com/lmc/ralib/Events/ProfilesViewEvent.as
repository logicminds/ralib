package com.lmc.ralib.Events
{
	import com.lmc.ralib.model.ProfileModel;
	
	import flash.events.Event;
	
	public class ProfilesViewEvent extends Event
	{
		public static const ADD:String = 'ProfilesViewEvent.add';
		public static const REMOVE:String = 'ProfilesViewEvent.remove';
		public static const EDIT:String = 'ProfilesViewEvent.edit';
		public static const CONNECT:String = 'ProfilesViewEvent.connect';
		public static const CONNECT_ACK:String = 'ProfilesViewEvent.connectack';
		public static const SWITCH:String = 'ProfilesViewEvent.switch';
		public static const SWITCH_ACK:String = 'ProfilesViewEvent.switchack';


		private var _profile:ProfileModel;
		
		public function ProfilesViewEvent(type:String, profile:ProfileModel=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_profile = profile;
		}
		public function get profile():ProfileModel{
			return _profile;
		}
		override public function clone():Event{
			return new ProfilesViewEvent(type, profile);
		}
	}
}