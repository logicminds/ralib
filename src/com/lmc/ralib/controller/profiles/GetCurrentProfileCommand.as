package com.lmc.ralib.controller.profiles
{
	import com.lmc.ralib.Events.ProfilesEvent;
	import com.lmc.ralib.model.AppKeeper;
	import com.lmc.ralib.model.ProfileModel;
	import com.lmc.ralib.model.ProfilesModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetCurrentProfileCommand extends Command
	{
		[Inject] public var model:ProfilesModel;
		[Inject] public var event:ProfilesEvent;
		[Inject] public var appkeeper:AppKeeper;
		public function GetCurrentProfileCommand()
		{
			super();
		}
		override public function execute():void{
			if (model.currentprofile){
				var profile:ProfileModel = model.currentprofile;
				appkeeper.clienttype = model.currentprofile.clienttype.name;
				dispatch(new ProfilesEvent(ProfilesEvent.CURRENT_PROFILE_RESULT, profile));

			}
		}
	}
}