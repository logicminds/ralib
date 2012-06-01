package com.lmc.ralib.model
{
	import org.robotlegs.mvcs.Actor;
	
	public class AppPreferences extends Actor
	{
		private var _eulaaccepted:Boolean = false;
		private var _firstview:Class;
		public function AppPreferences()
		{
			super();
		}
		public function set acceptEula(value:Boolean):void{
			_eulaaccepted = value;
		}
		public function get acceptEula():Boolean{
			return _eulaaccepted;
		}
		public function set firstview(value:Class):void{
			_firstview = value;
		}
		public function get firstview():Class{
			return _firstview;
		}
	}
}