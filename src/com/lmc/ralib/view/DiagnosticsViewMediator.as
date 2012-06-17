package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.BusyPopupEvent;
	import com.lmc.ralib.components.ViewMediatorBase;
	
	public class DiagnosticsViewMediator extends ViewMediatorBase
	{
		public function DiagnosticsViewMediator()
		{
			super();
		}
		public override function onRegister():void{
			dispatch(new BusyPopupEvent(BusyPopupEvent.CLOSE));

		}
	}
}