package com.lmc.ralib.services
{
	import com.lmc.ralib.Events.SettingsServiceEvent;
	
	import flash.events.NetStatusEvent;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	
	import org.robotlegs.mvcs.Actor;

	public class SettingsService extends Actor
	{
		private var settings:SharedObject;
		
		public function SettingsService()
		{
			super();
			settings = SharedObject.getLocal("settings");
		}
		public function setdata(name:String, obj:*):void{
			settings.data[name] = obj;
			writedata();
		}
		public function getdata(name:String, senddispatch:Boolean=true):*{
			if (settings && settings.data[name]){
				var obj:* = settings.data[name];
				if (senddispatch == true){
					dispatch(new SettingsServiceEvent(SettingsServiceEvent.RESULT, name, obj));
				}
			}
			else{
				if (senddispatch == true){
				dispatch(new SettingsServiceEvent(SettingsServiceEvent.RESULT, name));
				}
			}
			// returns results regardless of what they are	
			return settings.data[name];
		}
		
		private function writedata():void
		{
			//Verify Connection Status and run basic tests
			
			var flushStatus:String;
			
			flushStatus = settings.flush();
			
			if (flushStatus != null) { 
				switch(flushStatus) { 
					case SharedObjectFlushStatus.PENDING: 
						settings.addEventListener(NetStatusEvent.NET_STATUS, onFlushStatus); 
						break; 
					case SharedObjectFlushStatus.FLUSHED: 
						dispatch(new SettingsServiceEvent(SettingsServiceEvent.WRITE_SUCCESS));
						trace("wrote data to drive: success");
						break; 
				} 
			}
		}
		private function onFlushStatus(event: NetStatusEvent) : void { 
			dispatch(new SettingsServiceEvent(SettingsServiceEvent.WRITE_FAILURE));
			trace(event.info.code); 
		}
				
	}
}