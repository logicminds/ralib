package com.lmc.ralib.components
{
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.PopUpEvent;
	
	public class InputUserDialogMediator extends ViewMediatorBase
	{
		[Inject] public var view:InputUserDialog;
		public function InputUserDialogMediator()
		{
			super();
		}
		public override function onRegister():void{
			addViewListener(PopUpEvent.CLOSE, onClose);
		}
		private function onClose(event:PopUpEvent):void{
			dispatch(event);
			this.mediatorMap.removeMediator(this);
		}
	}
}