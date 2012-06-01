package com.lmc.ralib.model
{
	import flash.desktop.NativeApplication;
	import flash.system.Capabilities;
	import flash.utils.Dictionary;
	
	import org.robotlegs.mvcs.Actor;
	
	public class AppKeeper extends Actor
	{
		// this class is used to store view data throughout the program
		// things like scroll positions or last button clicked
		public var values:Dictionary;
		public function AppKeeper()
		{
			super();
			values = new Dictionary();
		}
		public function get clienttype():String{
			if (!values["clienttype"]){
				return "Foreman";
			}
			return values["clienttype"];
		}
		public function set clienttype(type:String):void{
			values["clienttype"] = type;
		}
		public function set clientVersion(ver:String):void{
			values["clientversion"] = ver;
		}
		public function get clientVersion():String{
			return values["clientversion"];
		}
		public function getApplicationVersion():String
		{
			var appXML:XML = NativeApplication.nativeApplication.applicationDescriptor;
			var ns:Namespace = appXML.namespace();
			return ((appXML.ns::version == undefined) ? (appXML.ns::versionNumber) : (appXML.ns::version));
		}
		public static function isAndroid():Boolean{
			return AppKeeper.OS == 'AND';
		}
		public static function isIOS():Boolean{
			return AppKeeper.OS == 'IOS';
		}
		public static function get OS():String{
			var platform:String = Capabilities.version;
			return platform.substr(0,3);
			
		}
	}
}