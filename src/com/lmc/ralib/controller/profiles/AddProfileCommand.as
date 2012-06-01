package com.lmc.ralib.controller.profiles
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.model.*;
	
	import org.robotlegs.mvcs.Command;
	public class AddProfileCommand extends Command
	{
		public function AddProfileCommand()
		{
			super();
		}
		
		[Inject] public var event:ProfilesEvent;
		[Inject] public var profiles:ProfilesModel;
		
		override public function execute():void{
			var profile:ProfileModel = profiles.findProfile((event.data as ProfileModel).id);
			if (profile){
				//already exists
				profiles.updateProfile(profile);
			}
			else{
				profiles.addProfile(event.data);
			}
		}
	}
}