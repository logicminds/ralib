package com.lmc.ralib.controller.Busy
{
	
	import com.lmc.ralib.components.BusyPopUpMediator;
	import com.lmc.ralib.components.BusyPopUpSkin;
	
	import flash.display.DisplayObjectContainer;
	
	import mx.core.FlexGlobals;
	import mx.managers.PopUpManager;
	
	import org.robotlegs.mvcs.Command;
	
	import spark.components.SkinnablePopUpContainer;
	
	public class ShowBusyCommand extends Command
	{
		public function ShowBusyCommand()
		{
			super();
		}
		override public function execute():void{
			
		}

	}
}