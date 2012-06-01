package com.lmc.ralib.components
{
	import com.lmc.ralib.Events.LicenseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class LicensePopUpMediator extends ViewMediatorBase
	{
		[Inject] public var view:LicensePopUp;
		public function LicensePopUpMediator()
		{
			super();
		}
		public override function onRegister():void{
			
			this.addViewListener(LicenseEvent.RESPONSE, onResponse);
		}
		private function onResponse(event:LicenseEvent):void{
			removeViewListener(LicenseEvent.RESPONSE, onResponse);
			dispatch(event);
			view.close();
			this.mediatorMap.removeMediator(this);
			

		}
	
	}
}