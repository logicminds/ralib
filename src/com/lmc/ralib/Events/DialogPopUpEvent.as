package com.lmc.ralib.Events
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class DialogPopUpEvent extends Event
	{
		public static const OPEN_USERPASS:String = 'com.lmc.ralib.Events.DialogPopUpEvent.openuserpass';
		public static const OPEN:String = 'com.lmc.ralib.Events.DialogPopUpEvent.open';
		public static const CLOSE:String = 'com.lmc.ralib.Events.DialogPopUpEvent.close';
		
		private var _message:String;
		private var _title:String
		private var _data:*;
		private var _username:String;
		private var _password:String;
		private var _prompttext:String;
		
		public function DialogPopUpEvent(type:String, data:*=null, message:String=null, title:String=null,
										 username:String=null, password:String=null, prompttext:String=null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
			_title = title;
			_data = data;
			_username = username;
			_password = password;
			_prompttext = prompttext;
		}
		public function get prompttext():String{
			return _prompttext;
		}
		public function get username():String{
			return _username;
		}
		public function get password():String{
			return _password;
		}
		public function get message():String
		{
			return _message;
		}
		public function get data():*{
			return _data;
		}
		public function get title():String{
			return _title;
		}
		override public function clone():Event{
			return new DialogPopUpEvent(type,data,message,title,username,password, prompttext);
		}
	}
}