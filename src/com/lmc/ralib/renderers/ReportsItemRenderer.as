package com.lmc.ralib.renderers
{
	import assets.Chevron;
	import assets.icons.goodicon24;
	
	import com.lmc.ralib.model.ReportModel;
	import com.lmc.ralib.skins.assets.*;
	import com.lmc.ralib.utils.LogicMindsUtils;
	
	import mx.core.IDataRenderer;
	
	import spark.components.IconItemRenderer;
	import spark.core.SpriteVisualElement;
	import spark.utils.MultiDPIBitmapSource;
	
	public class ReportsItemRenderer extends IconItemRenderer implements IDataRenderer
	{
		public static const V_PADDING:int = 6;
		public static const H_PADDING:int = 6;
		public static const V_GAP:int = 4;
		public static const H_GAP:int = 15;
		private var utilsobj:LogicMindsUtils = new LogicMindsUtils();
		private var icon:SpriteVisualElement;
		private var cm:MultiDPIBitmapSource = new MultiDPIBitmapSource();
		
		public function ReportsItemRenderer()
		{
			super();
			this.iconFunction = myIconFunction;
			this.decorator = new Chevron();
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
				{
					/*cm.source160dpi = "@Embed('assets/icons/bad32.png')";
					cm.source240dpi = "@Embed('assets/icons/bad48.png')";
					cm.source320dpi = "@Embed('assets/icons/bad64.png')"; */
					icon = new badresulticon() as SpriteVisualElement;
					break;
				}
				case "Success":	{
					/*cm.source160dpi = "assets/icons/goodcheck32.png";
					cm.source240dpi = "assets/icons/goodcheck48.png";
					cm.source320dpi = "assets/icons/goodcheck64.png"; */
					icon = new goodicon24() as SpriteVisualElement;
					break;
				}
				case "Modified":{
					/*cm.source160dpi = "assets/icons/gear32.png";
					cm.source240dpi = "assets/icons/gear48.png";
					cm.source320dpi = "assets/icons/gear64.png"; */
					icon = new modifiedicon() as SpriteVisualElement;
					
					break;
				}
					
				default:
				{	
					icon = new nexticon() as SpriteVisualElement;
					icon.visible = false;
					this.setElementSize(icon, 0, 0);
					break;
				}
			}
			//return cm.getSource(applicationDPI);
			icon.cacheAsBitmap = true;
			return icon;
		}
	/*	override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
			
		}
		override protected function createChildren():void{
		
		}
		override protected function measure():void
		{
		}
		override protected function createMessageDisplay():void
		override protected function createLabelDisplay():void

		*/
	}
}