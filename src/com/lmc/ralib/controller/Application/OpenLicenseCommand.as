package com.lmc.ralib.controller.Application
{
	import com.lmc.ralib.Events.LicenseEvent;
	import com.lmc.ralib.components.LicensePopUp;
	import com.lmc.ralib.components.LicensePopUpMediator;
	import com.lmc.ralib.services.SettingsService;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import mx.managers.PopUpManager;
	
	import org.robotlegs.mvcs.Command;
	
	public class OpenLicenseCommand extends Command
	{
		[Inject] public var model:SettingsService;

		private var urlLoader:URLLoader;
		private var licensepopup:LicensePopUp;
		public function OpenLicenseCommand()
		{
			super();
		}
		public override function execute():void{

			licensepopup = new LicensePopUp();
			mediatorMap.createMediator(licensepopup);
			// create the SkinnablePopUpContainer
			
			if (!checklicense()){
				getlicensefromfile();
				this.commandMap.detain(this);

			}
			else{
				dispatch(new LicenseEvent(LicenseEvent.RESULT, true));

			}

			
		}
		private function checklicense():Boolean{
			var license:Object = model.getdata("license",false);
			if (license){
				return license.accepted;
			}
			return false;
		//	return true;
		}
		public function getlicensefromfile(path:String="assets/gpl.txt"):void{
			var urlRequest:URLRequest = new URLRequest(path);
			urlLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT; // default
			urlLoader.addEventListener(Event.COMPLETE, urlLoader_complete);
			urlLoader.load(urlRequest);
		}
		private function urlLoader_complete(evt:Event):void {
			licensepopup.license = evt.target.data;
			licensepopup.open(this.contextView, true);
			PopUpManager.centerPopUp(licensepopup);
			this.commandMap.release(this);
		}
	}
}