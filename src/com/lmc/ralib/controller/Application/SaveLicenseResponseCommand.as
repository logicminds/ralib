package com.lmc.ralib.controller.Application
{
	import com.lmc.ralib.Events.LicenseEvent;
	import com.lmc.ralib.services.SettingsService;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class SaveLicenseResponseCommand extends Command
	{
		[Inject] public var event:LicenseEvent;
		[Inject] public var model:SettingsService;

		public function SaveLicenseResponseCommand()
		{
			super();
		}
		public override function execute():void{
			
			// write value to disk or exit program
			if (event.accepted){
				// Create the Remote Service Ojbect and manually inject it
				model.setdata("license", {accepted:true});
				dispatch(new LicenseEvent(LicenseEvent.RESULT, event.accepted));

			}
			else{
				var exitingEvent:Event = new Event(Event.EXITING, false, true);
				NativeApplication.nativeApplication.dispatchEvent(exitingEvent);
				if (!exitingEvent.isDefaultPrevented()) {
					NativeApplication.nativeApplication.exit();
				}
			}
				
		}
	}
}