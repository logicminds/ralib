package com.lmc.ralib.services
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.BusyPopupEvent;
	import com.lmc.ralib.Events.RestClientEvent;
	
	import org.robotlegs.mvcs.Actor;

	[RemoteClass(alias="com.lmc.ralib.services.RemoteServiceBase")]
	public class RemoteServiceBase extends Actor implements ClientInterface
	{
		public var numitems:int;
		public function showBusy(value:Boolean):void{
			if (value){
				dispatch(new BusyPopupEvent(BusyPopupEvent.OPEN));
				
			}
			else{
				dispatch(new BusyPopupEvent(BusyPopupEvent.CLOSE));

			}
			
		}
		public function gethostclasses(host:String):void{
			
		}
		public function RemoteServiceBase()
		{
			super();
		}
		public function createSerialObject(eventtype:String, serializedClass:Class):Object{
			var obj:Object = new Object();
			obj.eventtype = eventtype;
			obj.serializedClass = serializedClass;
			return obj;
		}
	
		public function type():String{
			return null;
		}
		public function version():String{
			return null;
		}
		public function notsupported():void{
			dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "Feature not supported with the " + type() + " client" ));

		}
		public function updateHostGroup(data:Object):void{
			notsupported();

		}
		public function updateMultipleHostGroup(data:Object):void{
			notsupported();
			
		}
		public function getclasses():void{
			notsupported();

		}
		public function getBookmarks():void{
			notsupported();
		}
		public function setupClient(host:String, port:String, creds:String, secure:Boolean):void{
			notsupported();
				

		}
		public function gethosts(query:String=null, etype:String=null):void{
			notsupported();

		}
		public function gethostinfo(host:String, hostresource:String=null):void{
			notsupported();

		}
		public function gethostgroups():void{
			notsupported();

		}
		public function gethostgroup(id:String):void{
			notsupported();

		}
		public function getstatus():void{
			notsupported();

		}
		public function search(resource:String, query:String):void{
			notsupported();

		}
		public function getreports(page:int=1, reportid:int=-1, query:String=null, numreports:int=10):void{
			notsupported();

		}
		public function getfactvalues(factname:String):void{
			notsupported();

		}
		public function getfacts():void{
			notsupported();

		}
		public function gethostfacts(host:String):void{
			notsupported();

		}
		public function getproxylist():void{
			notsupported();

		}
		public function getproxyinfo(id:int=0, type:String="puppetca"):void{
			notsupported();

		}
		public function getdashboard():void{
			notsupported();

		}
		public function updateHost(data:Object, hostname:String):void{
			notsupported();

		}
		public function createGroup(data:Object):void{
			notsupported();

		}
	}
}