package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.HelpEvent;
	import com.lmc.ralib.components.ViewMediatorBase;
	
	public class ProfileClientSettingsMediator extends ViewMediatorBase
	{
		public function ProfileClientSettingsMediator()
		{
			super();
		}
		public override function onRegister():void{
			this.addViewListener(HelpEvent.OPENHELP, dispatch);

		}
		
	}
}