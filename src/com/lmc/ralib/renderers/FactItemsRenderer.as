package com.lmc.ralib.renderers
{
	import com.lmc.ralib.components.*;
	
	import mx.core.IDataRenderer;
	
	import spark.components.IconItemRenderer;
	import spark.components.LabelItemRenderer;
	import spark.core.SpriteVisualElement;

	public class FactItemsRenderer extends LabelItemRenderer implements IDataRenderer
	{
		public static const V_PADDING:int = 6;
		public static const H_PADDING:int = 6;
		public static const V_GAP:int = 4;
		public static const H_GAP:int = 15;
		private var icon:SquareButton;
		//[Bindable] public var labelField:String; 
		public function FactItemsRenderer()
		{
			super();
			//labelField="value"
			cacheAsBitmap = true;

			
		}
		override protected function createChildren():void{
			super.createChildren();
			icon = new SquareButton();
			icon.cacheAsBitmap = true;
			this.addChild(icon);
			
		}
		override protected function measure():void
		{
			var calculatedHeight:Number = getElementPreferredHeight(labelDisplay);
			var calculatedWidth:Number;
			// Check to see if the image is taller
			if (getElementPreferredHeight(icon) + (V_PADDING * 2) > calculatedHeight)
				calculatedHeight = getElementPreferredHeight(icon) + (V_PADDING * 2);
			
			// Round
			calculatedHeight = Math.floor(calculatedHeight);
			calculatedWidth = Math.floor(icon.width + labelDisplay.width)
			
			measuredHeight = calculatedHeight;
			measuredWidth = calculatedWidth;
		}
		override public function set data(value:Object):void
		{
			if(value != null)
			{
				super.data = value;
				icon.number = value.count;
			}
		}
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
					
			// Update styles on textFields
			labelDisplay.commitStyles();
			
			// edit button
			var iconWidth:Number = getElementPreferredWidth(icon)*2;
			var iconHeight:Number = getElementPreferredHeight(icon);
			setElementSize(icon, iconWidth, iconHeight);
			// icon is always right aligned, vertically centered
			var iconY:Number = Math.round(0.5 * (unscaledHeight - iconHeight));
			setElementPosition(icon, unscaledWidth - H_PADDING - iconWidth, iconY);
			
			// labelDisplay
			var elementWidth:Number = unscaledWidth - (H_PADDING * 2) - H_GAP - 20;
			var labelHeight:Number = getElementPreferredHeight(labelDisplay) + 4;
			var labelY:Number = Math.round(0.5 * (unscaledHeight - labelHeight));
			
			setElementSize(labelDisplay, elementWidth, Math.min(labelHeight, 60));
			setElementPosition(labelDisplay, H_GAP, labelY);
			
			// Invailidate the size so that we can revalidate text due to potential reflow
			if (labelHeight != getElementPreferredHeight(labelDisplay) + 4)
				invalidateSize();
		}
		//--------------------------------------------------------------------------
		//
		//  Overridden methods: LabelItemRenderer
		//
		//--------------------------------------------------------------------------
		
		// The message field is used to display the name of the it.  Customize its 
		// appearance by overriding its creation methods
		/*override protected function createLabelDisplay():void{
			
		}
		
		*/


	}
}