package com.lmc.ralib.model
{
	import flash.utils.ByteArray;
	
	import mx.utils.Base64Decoder;
	import mx.utils.Base64Encoder;
	import mx.utils.UIDUtil;
	
	import org.robotlegs.mvcs.Actor;

	[RemoteClass(alias="com.lmc.ralib.model.ProfileModel")]
	
	[Bindable]
	public class ProfileModel extends Actor
	{
		public var name:String;
		public var timeout:int = 30;
		public var id:String;
		public var host:String;
		public var port:String;
		public var usehttps:Boolean = false;
		public var currentprofile:Boolean;
		public var mycredentials:String;
		public var clienttype:Object;
		
		public function ProfileModel(newprofile:Object=null)
		{
			super();
			
			// create new object
			if (! newprofile){
				
				id = UIDUtil.createUID();
				this.name = "";
				this.host = "";
				this.port = "";
				this.usehttps = false;
				this.currentprofile = false;
				this.mycredentials = null;
				this.clienttype = new Object();
				
			}
			else{
				copy(newprofile);
			}
		}
		
		
		public function copy(item:Object):void{
			this.name = item.name;
			this.host = item.host;
			this.port = item.port;
			this.id = item.id;
			this.usehttps = item.usehttps;
			this.currentprofile = item.currentprofile;
			this.clienttype = item.clienttype;
			if (item.mycredentials)
				this.mycredentials = item.mycredentials;
			else 
				this.mycredentials = "";
		}
		public function clone(item:Object):ProfilesModel{
			// this will clone the object and return it
			//return new ProfileModel(item);
			return null;
			
		}
		
		public function get username():String{
			if (this.mycredentials){
				var decoder:Base64Decoder = new Base64Decoder();
				decoder.decode(this.mycredentials);
				var obj:ByteArray = decoder.toByteArray();
				var creds:Array = obj.toString().split(":");
				return creds[0];
			}
			else
				return "";
			
		}
		
		public function get password():String{
			
			if (this.mycredentials){
				var decoder:Base64Decoder = new Base64Decoder();
				decoder.decode(this.mycredentials);
				var obj:ByteArray = decoder.toByteArray();
				var creds:Array = obj.toString().split(":");
				return creds[1];
				
			}
			else
				return "";
			
			
		}
		public function get credentials():String{
			return this.mycredentials;
		}
		public function setcredentials(user:String, pass:String):void{
			
			var encoder:Base64Encoder = new Base64Encoder();
			// this prevents the encoder from sticking /n in long passwords
			encoder.insertNewLines = false;
			encoder.encode(user + ":" + pass);
			// store in memory as base64 or something encrypted
			this.mycredentials = encoder.toString();
			
		}
		public function comparebyname(item:Object):Boolean{
			if (this.name == item.name)
				return true;
			else
				return false;
		}
		public function equals(item:Object):Boolean{
			
			if (! name == item.name){
				return false;
			}
			if (! host == item.host){
				return false;
			}
			if (! port == item.port){
				return false;
			}
			if (! id == item.id){
				return false;
			}
			if (! usehttps == item.usehttps){
				return false;
			}
			if (! currentprofile == item.currentprofile){
				return false;
			}
			
			if (! mycredentials == item.mycredentials){
				return false;
			}
			if (! clienttype == item.clienttype){
				return false
			}
			
			// items are the same
			return true;
			
		}
	}
}


