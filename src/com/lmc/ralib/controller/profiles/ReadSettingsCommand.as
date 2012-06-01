package com.lmc.ralib.controller.profiles
{
	import com.lmc.ralib.Events.SettingsServiceEvent;
	import com.lmc.ralib.services.SettingsService;
	
	import org.robotlegs.mvcs.Command;
	
	public class ReadSettingsCommand extends Command
	{
		[Inject] public var service:SettingsService;
		[Inject] public var event:SettingsServiceEvent;
		
		public function ReadSettingsCommand()
		{
			super();
		}
		override public function execute():void{
				service.getdata(event.dataname);
		}
	}
}