package com.lmc.ralib.components
{
	import com.lmc.ralib.Events.*;
	
	import org.robotlegs.mvcs.Mediator;
	public class BusyPopUpMediator extends Mediator
	{
		[Inject] public var view:BusyPopUp;
		
		public function BusyPopUpMediator()
		{
			super();
			
		}
		public override function onRegister():void{
			addContextListener(BusyPopupEvent.OPEN, onOpen);
			addContextListener(BusyPopupEvent.CLOSE, onClose);
		}
		private function onOpen(event:BusyPopupEvent):void{
			view.visible = true;
			view.open(this.contextView,false);
		//	eventMap.mapListener(view, AlertEvent.OPEN, dispatch);

			
		}
		private function onClose(event:BusyPopupEvent):void{
			view.close();
			
			//this.mediatorMap.removeMediator(this);
		}
	}
}