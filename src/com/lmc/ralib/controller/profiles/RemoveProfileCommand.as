package com.lmc.ralib.controller.profiles
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.model.*;
	
	import org.robotlegs.mvcs.Command;
	public class RemoveProfileCommand extends Command
	{
		public function RemoveProfileCommand()
		{
			super();
		}
		[Inject] public var profiles:ProfilesModel;
		[Inject] public var event:ProfilesEvent;
		
		override public function execute():void{
			dispatch(new ApplicationEvent(ApplicationEvent.CLEAR_CACHE_REQUEST));

			profiles.deleteProfile(event.data);
		}
	}
}