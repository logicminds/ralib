package com.lmc.ralib.controller.profiles
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ProfilesEvent;
	import com.lmc.ralib.Events.SettingsServiceEvent;
	import com.lmc.ralib.model.ProfilesModel;
	import com.lmc.ralib.services.ClientInterface;
	import com.lmc.ralib.services.RemoteService;
	import com.lmc.ralib.services.RemoteServiceBase;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetStoredProfilesCommand extends Command
	{
		[Inject] public var remoteservice:RemoteService;
		public var remoteclient:RemoteServiceBase;
		[Inject] public var event:SettingsServiceEvent;
		[Inject] public var model:ProfilesModel;
		private var storedmodel:ProfilesModel;
		public function GetStoredProfilesCommand()
		{
			super();
		}
		override public function execute():void{
			// need a better way of handling multiple dispatch from writesettings
			
			if (event.newdata ){
				storedmodel = event.newdata as ProfilesModel;
				model.copy(storedmodel);
			}
			if (model.currentprofile){
				remoteclient = remoteservice.getService(model.currentprofile);
				this.injector.unmap(RemoteServiceBase);
				this.injector.injectInto(remoteclient);
				this.injector.mapValue(RemoteServiceBase, remoteclient);
				// get the hosts as most of the application relies on hosts being present
				dispatch(new ClientRequestEvent(ClientRequestEvent.HOSTS,false));
			}
			else if (model.profiles.length == 0){
				dispatch(new AlertEvent(AlertEvent.OPEN,"Notice", "No Profile Exists, please create a connection profile"));
			}
			else{
				dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "No Connection Profile is Selected"));
			}
			// notify receiver the model was updated.
			dispatch(new ProfilesEvent(ProfilesEvent.PROFILESRESULT,model, "Profiles"));
			
			
		}
	}
}