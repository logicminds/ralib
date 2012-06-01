package com.lmc.ralib.Events
{
	import com.lmc.ralib.model.ProfileModel;
	import com.lmc.ralib.model.ProfilesModel;
	
	import flash.events.Event;
	
	public class ProfilesEvent extends Event
	{
		public static const ALLREADY_EXISTS:String = 'ProfilesEvent.already_exists';
		public static const UPDATED:String = 'ProfilesEvent.updated';
		public static const REMOVED:String = 'ProfilesEvent.removed';
		public static const ADDED:String = 'ProfilesEvent.added';
		public static const CLEARED:String = 'ProfilesEvent.cleared';
		public static const ADD_REQUEST:String = 'ProfilesEvent.addrequest';
		public static const EDIT_REQUEST:String = 'ProfilesEvent.editrequest';
		public static const GET_REQUEST:String = 'ProfilesEvent.getrequest';
		public static const GET_PROFILES_REQUEST:String = 'ProfilesEvent.getprofilesrequest';
		public static const PROFILESRESULT:String = 'ProfilesEvent.profilesresult';
		public static const DELETE_REQUEST:String = 'ProfilesEvent.getrequest';
		public static const CURRENT_PROFILE_REQUEST:String = 'ProfilesEvent.currentprofilerequest';
		public static const CURRENT_PROFILE_RESULT:String = 'ProfilesEvent.currentprofileresult';
		public static const SET_CURRENT_PROFILE_REQUEST:String = 'ProfilesEvent.setcurrentprofilerequest';
		public static const SET_CURRENT_PROFILE_RESULT:String = 'ProfilesEvent.setcurrentprofileresult';



		private var _data:*;
		private var _name:String;
		
		public function ProfilesEvent(type:String, data:*=null, name:String=null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
			_name = name;
		}
		public function get data():*{
			return _data;
		}
		public function get name():String{
			return _name;
		}
		override public function clone():Event{
			return new ProfilesEvent(type, data,name);
		}
	}
}