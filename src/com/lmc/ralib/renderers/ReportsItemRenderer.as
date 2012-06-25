package com.lmc.ralib.renderers
{
	import assets.icons.goodicon24;
	
	import com.lmc.ralib.graphics.Chevron;
	import com.lmc.ralib.model.ReportModel;
	import com.lmc.ralib.skins.assets.*;
	import com.lmc.ralib.utils.LogicMindsUtils;
	
	import mx.core.DPIClassification;
	import mx.core.FlexGlobals;
	import mx.core.IDataRenderer;
	
	import spark.components.IconItemRenderer;
	import spark.components.Image;
	import spark.core.SpriteVisualElement;
	import spark.primitives.BitmapImage;
	import spark.primitives.Graphic;
	import spark.utils.MultiDPIBitmapSource;
	
	public class ReportsItemRenderer extends IconItemRenderer implements IDataRenderer
	{
		public static const V_PADDING:int = 6;
		public static const H_PADDING:int = 6;
		public static const V_GAP:int = 4;
		public static const H_GAP:int = 15;
		private var iconwidth:int;
		private var iconheight:int;
		private var utilsobj:LogicMindsUtils = new LogicMindsUtils();
		private var icon:*;
		private var badicon:Class;
		private var goodicon:Class;
		private var gearicon:Class;
		
		[Embed(source='assets/icons/gear32.png')]
		private var gear160:Class;
		
		[Embed(source='assets/icons/gear48.png')]
		private var gear240:Class;
		
		[Embed(source='assets/icons/gear64.png')]
		private var gear320:Class;
		
		[Embed(source='assets/icons/bad32.png')]
		private var bad160:Class;
		
		[Embed(source='assets/icons/bad48.png')]
		private var bad240:Class;
		
		[Embed(source='assets/icons/bad64.png')]
		private var bad320:Class;
		
		[Embed(source='assets/icons/check32.png')]
		private var check160:Class;
		
		[Embed(source='assets/icons/check48.png')]
		private var check240:Class;
		
		[Embed(source='assets/icons/check64.png')]
		private var check320:Class;
		
		[Embed(source = "assets/images/fleche.png")]
		private var _decorator:Class;
		
		public function ReportsItemRenderer()
		{
			
			
		}
		override protected function createChildren():void{
			super.createChildren();
			
			switch (FlexGlobals.topLevelApplication.applicationDPI)
			{
				case DPIClassification.DPI_320:
					
					badicon = bad320;
					goodicon = check320;
					gearicon = gear320;
				
					break;
				case DPIClassification.DPI_240:
					
					badicon = bad240;
					goodicon = check240;
					gearicon = gear240;
					
					break;
				default:
					// default 160
					badicon = bad160;
					goodicon = check160;
					gearicon = gear160;
					
					break;
			}
			this.iconFunction = myIconFunction;
			decorator = _decorator;			
			this.labelFunction = mylabelfunction;
			this.messageFunction = mymessagefunction;
			this.cacheAsBitmap = true;
		}
		override public function set data(value:Object):void
		{
			if(value != null)
			{
				super.data = value;
			
			}
		}
		private function mymessagefunction(item:ReportModel):String{
			if (item.reported_at == ""){
				return "";
			}
			return utilsobj.timeago(item.reported_at);
		}
		private function mylabelfunction(item:ReportModel):String{
			return item.host;
		}
		private function myIconFunction(item:ReportModel):Object{			
			switch(item.summary)
			{
				case "Failed":
					return badicon;
					//icon.cacheAsBitmap = true;
					break;
				case "Success":	
					return goodicon;
					//icon.cacheAsBitmap = true;
					break;
				case "Modified":
					return gearicon;
					//icon.cacheAsBitmap = true;
					break;
				default:
					return null;
					//icon.visible = false;
					//this.setElementSize(icon, 0, 0);
					break;
			}			
			return null;
		}
		
	/*	override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.layoutContents(unscaledWidth, unscaledHeight);
		}
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void{
			super.drawBackground(unscaledWidth, unscaledHeight);
		
			
		} */
		/*
		override protected function measure():void
		{
		}
		override protected function createMessageDisplay():void
		override protected function createLabelDisplay():void

		*/
	}
}