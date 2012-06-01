package com.lmc.ralib.controller.profiles
{
	import com.lmc.ralib.model.*;
	import com.lmc.ralib.components.*;
	
	import org.robotlegs.mvcs.Command;
	import com.lmc.ralib.Events.ProfilesEvent;
	
	public class GetProfileFormCommand extends Command
	{
		public function GetProfileFormCommand()
		{
			super();
		}
		
		[Inject] public var event:ProfilesEvent;
		
		override public function execute():void{
			var profile:ProfileModel = event.data;
			
		}
	}
}