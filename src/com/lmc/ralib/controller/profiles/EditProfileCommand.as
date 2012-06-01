package com.lmc.ralib.controller.profiles
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.model.*;
	
	import org.robotlegs.mvcs.Command;
	public class EditProfileCommand extends Command
	{
		public function EditProfileCommand()
		{
			super();
		}
		
		[Inject] public var event:ProfilesEvent;
		[Inject] public var profiles:ProfilesModel;
		
		override public function execute():void{
			profiles.updateProfile(event.data);
			
		}
	}
}