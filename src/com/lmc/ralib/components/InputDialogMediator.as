package com.lmc.ralib.components
{
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.PopUpEvent;
	
	public class InputDialogMediator extends ViewMediatorBase
	{
		public function InputDialogMediator()
		{
			super();
		}
		[Inject] public var view:InputDialog;
		public override function onRegister():void{
			addViewListener(PopUpEvent.CLOSE, onClose);
		}
		private function onClose(event:PopUpEvent):void{
			// this helps us use the native extension popups be consistant
			var name:String = event.data;
			event.data = {name: name};
			dispatch(event);
			this.mediatorMap.removeMediator(this);
		}
	}
}