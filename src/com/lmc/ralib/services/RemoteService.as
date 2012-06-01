package com.lmc.ralib.services
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.BusyPopupEvent;
	import com.lmc.ralib.model.ProfileModel;
	
	import org.robotlegs.mvcs.Actor;
	
	public class RemoteService extends Actor
	{
		public var isAlive:Boolean = false;
		private var _service:RemoteServiceBase;
		public function RemoteService()
		{
			super();
		}
	
		public function getService(profile:ProfileModel):RemoteServiceBase{
	
			if (_service && _service.type == profile.clienttype.name){
				// exists and is of same type
				isAlive = true;
				return _service;
			}
			else{
				// either not the same type or not created
				return createservice(profile);
			}
		
		}
		public function get service():RemoteServiceBase{
			return _service;
		}
		public function createservice(profile:ProfileModel):RemoteServiceBase{
			var clientname:String;
			if (!profile.clienttype){
				// the type is not being set for some reason
				dispatch(new AlertEvent(AlertEvent.OPEN, "Alert", "Client Type not set in profile: " + profile.name + "\n Using foreman client"));
				trace("Client Type not set in profile");
				clientname = "Foreman";
				
			}
			else{
				clientname = profile.clienttype.name
			}
			switch(clientname){
				case "Test":
					_service = new TestClient();
					_service.numitems = profile.clienttype.value;
					break;
				case "Foreman":
					_service = new ForemanClient();
					_service.setupClient(profile.host, profile.port,profile.credentials, profile.usehttps);
					break;
				case "Puppet":
					// doesn't exist yet
					break;
				default:
					case "Foreman":
					_service = new ForemanClient();
					_service.setupClient(profile.host, profile.port,profile.credentials, profile.usehttps);
					break;	
				
				
			}
			return _service;
				
		}
		
	}
}