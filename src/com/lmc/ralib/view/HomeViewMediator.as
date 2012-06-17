package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.BusyPopupEvent;
	import com.lmc.ralib.components.ViewMediatorBase;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class HomeViewMediator extends ViewMediatorBase
	{
		public function HomeViewMediator()
		{
			super();
		}
		public override function onRegister():void{
			dispatch(new BusyPopupEvent(BusyPopupEvent.CLOSE));

		}
	}
}