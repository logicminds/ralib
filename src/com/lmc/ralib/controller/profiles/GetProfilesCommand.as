package com.lmc.ralib.controller.profiles
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.model.ProfilesModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetProfilesCommand extends Command
	{
		[Inject] public var model:ProfilesModel;
		public function GetProfilesCommand()
		{
			super();
		}
		override public function execute():void{
			dispatch(new ProfilesEvent(ProfilesEvent.PROFILESRESULT, model));
			
		}
	}
}