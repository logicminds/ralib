package com.lmc.ralib.components
{
	import flash.events.IEventDispatcher;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.View;
	
	public class ViewMediatorBase extends Mediator
	{
		public function ViewMediatorBase()
		{
			super();
		}
		override public function preRegister():void{
			if (flexAvailable && (viewComponent is View) && !viewComponent['initialized']){
				IEventDispatcher(viewComponent).addEventListener('viewActivate', onCreationComplete,
					false,0, true);
			}
			else{
				onRegister();
			}
		}
		
	}
}