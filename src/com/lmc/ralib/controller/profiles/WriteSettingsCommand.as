package com.lmc.ralib.controller.profiles
{
	import com.lmc.ralib.Events.SettingsServiceEvent;
	import com.lmc.ralib.model.ProfilesModel;
	import com.lmc.ralib.services.SettingsService;
	
	import org.robotlegs.mvcs.Command;
	
	public class WriteSettingsCommand extends Command
	{
		[Inject] public var event:SettingsServiceEvent;
		[Inject] public var model:SettingsService;
		
		public function WriteSettingsCommand()
		{
			super();
		}
		override public function execute():void{
			model.setdata(event.dataname, event.newdata);
		}
	}
}