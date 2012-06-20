package com.lmc.ralib.components
{
	import com.lmc.ralib.Events.AlertEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.system.Capabilities;
	import flash.utils.Timer;
	
	import mx.core.DPIClassification;
	import mx.core.FlexGlobals;
	
	import spark.components.SkinnablePopUpContainer;

	public class ProcessingBusyPopUp extends SkinnablePopUpContainer
	{
		public function ProcessingBusyPopUp()
		{
			super();
			switch (FlexGlobals.topLevelApplication.applicationDPI)
			{
				case DPIClassification.DPI_320:
				{
					height = 200;
					width = 200;
					break;
				}
				case DPIClassification.DPI_240:
				{
					height = 150;
					width = 150;
					break;
				}
				default:
				{
					// default PPI160
					height = 112;
					width = 112;
					break;
				}
			}
			setStyle("skinClass", com.lmc.ralib.components.BusyPopUpSkin);
			setStyle("backgroundAlpha",0.5);
			setStyle("backgroundColor",0x000000);
			setStyle("symbolColor",0xFF0000);
			
			
		}
		public override function open(owner:DisplayObjectContainer, modal:Boolean=false):void{
			this.visible = true;
			super.open(owner, modal);
			positionPopUp();
			
		}
		
		public function positionPopUp():void
		{
			// use the View x, y coords to position the popup
			var point:Point = new Point(x, y);
			// convert the View x,y to global so this can be laid out in nested Views
			this.x = (FlexGlobals.topLevelApplication.width / 2) - (this.width / 2);
			this.y = (FlexGlobals.topLevelApplication.height / 2 ) - (this.height / 2 );
			
		}
		
	}
}