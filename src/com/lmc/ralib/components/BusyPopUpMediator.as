package com.lmc.ralib.components
{
	import com.lmc.ralib.Events.*;
	
	import org.robotlegs.mvcs.Mediator;
	public class BusyPopUpMediator extends Mediator
	{
		[Inject] public var view:BusyPopUp;
		private var isretreiving:Boolean = false;
		private var isprocessing:Boolean = false;
		public function BusyPopUpMediator()
		{
			super();
			
		}
		public override function onRegister():void{
			addContextListener(BusyPopupEvent.OPEN, onOpen);
			addContextListener(BusyPopupEvent.OPEN_COMPUTING, onOpen);
			addContextListener(BusyPopupEvent.CLOSE_COMPUTING, onClose);
			addContextListener(BusyPopupEvent.CLOSE, onClose);
		}
		private function onOpen(event:BusyPopupEvent):void{
			if (event.type == BusyPopupEvent.OPEN){
				isretreiving = true;
			}
			else if (event.type == BusyPopupEvent.OPEN_COMPUTING){
				isprocessing = true;
			}
			view.visible = true;
			view.open(this.contextView,false);

		}
		private function onClose(event:BusyPopupEvent):void{
			if (!(isretreiving && isprocessing)){
				view.close();
			}
			if (event.type == BusyPopupEvent.CLOSE){
				isretreiving = false;
			}
			else if (event.type == BusyPopupEvent.CLOSE_COMPUTING){
				isprocessing = false;
			}
			
			
			
		}
	}
}