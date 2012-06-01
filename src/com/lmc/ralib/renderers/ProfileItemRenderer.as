package com.lmc.ralib.renderers
{
	import com.lmc.ralib.Events.customClickEvent;
	import com.lmc.ralib.model.ProfileModel;
	
	import flash.desktop.Icon;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.IDataRenderer;
	
	import com.lmc.ralib.skins.assets.statusicon;
	
	import spark.components.Application;
	import spark.components.Button;
	import spark.components.CheckBox;
	import spark.components.IconItemRenderer;
	import spark.components.Image;
	import spark.components.LabelItemRenderer;
	import spark.components.List;
	import spark.core.SpriteVisualElement;
	import spark.events.ListEvent;
	import spark.utils.MultiDPIBitmapSource;
	
	
	public class ProfileItemRenderer extends LabelItemRenderer implements IDataRenderer
	{
		//
		// Constants
		//
		public static const IMAGE_WIDTH:int = 150;
		public static const IMAGE_HEIGHT:int = 130;
		public static const V_PADDING:int = 6;
		public static const H_PADDING:int = 6;
		public static const V_GAP:int = 4;
		public static const H_GAP:int = 15;
		
		
		//= new skins.assets.statusicon() as SpriteVisualElement;
		private var iconobj:SpriteVisualElement; 
		private var editbutt:Button; 
		private var checkimage:Image;
		private var blankIcon:Icon;
		private var size:Number;
		private var cm:MultiDPIBitmapSource;
		
		[Embed(source='assets/icons/goodcheck16.png')]
		private var check16:Class;
		
		[Embed(source='assets/icons/goodcheck24.png')]
		private var check24:Class;
		
		[Embed(source='assets/icons/goodcheck32.png')]
		private var check32:Class;
		
		public function ProfileItemRenderer()
		{
			super();
			
			this.cacheAsBitmap = true;
			// Add mouse click listener
			//addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
		}
		private function setCheckImage(item:Object):void{
			if (item.currentprofile){
				checkimage.source = cm.getSource(applicationDPI);
				
			}
			else{
				checkimage.source = null;
				
			}
		}
		override protected function measure():void
		{
			var calculatedHeight:Number = getElementPreferredHeight(labelDisplay);
			var calculatedWidth:Number;
			// Check to see if the image is taller
			if (getElementPreferredHeight(checkimage) + (V_PADDING * 2) > calculatedHeight)
				calculatedHeight = getElementPreferredHeight(checkimage) + (V_PADDING * 2);
			
			// Round
			calculatedHeight = Math.floor(calculatedHeight);
			calculatedWidth = Math.floor(checkimage.width + labelDisplay.width)
				
			measuredHeight = calculatedHeight;
			measuredWidth = calculatedWidth;

			
			
		}
		override protected function createChildren():void
		{
			super.createChildren();
			cm = new MultiDPIBitmapSource();
			cm.source160dpi = check16;
			cm.source240dpi = check24;
			cm.source320dpi = check32;
			checkimage = new Image();
			//checkimage.styleName = "checkImage";
			checkimage.cacheAsBitmap = true;
			addChild(checkimage);
			
			editbutt = new Button();
			editbutt.label = "Edit";
			editbutt.addEventListener(MouseEvent.CLICK, editprofileClickHandler);
			editbutt.cacheAsBitmap = true;
			addChild(editbutt);
		}
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void{
			// Update styles on textFields
			labelDisplay.commitStyles();
			
			// edit button
			var editbuttWidth:Number = getElementPreferredWidth(editbutt) + 10;
			var editbuttHeight:Number = getElementPreferredHeight(editbutt) -10;
			setElementSize(editbutt, editbuttWidth, editbuttHeight);
			// editbutton is always right aligned, vertically centered
			var editbuttY:Number = Math.round(0.5 * (unscaledHeight - editbuttHeight));
			setElementPosition(editbutt, unscaledWidth - H_PADDING - editbuttWidth, editbuttY);
			
			// checkimage
			var checkimageWidth:Number = getElementPreferredWidth(checkimage);
			var checkimageHeight:Number = getElementPreferredHeight(checkimage);
			setElementSize(checkimage, checkimageWidth, checkimageHeight);
			var checkimageY:Number = Math.round(0.5 * (unscaledHeight - checkimageHeight));
			setElementPosition(checkimage, H_PADDING, checkimageY);
			
			// labelDisplay
			var elementWidth:Number = unscaledWidth - (H_PADDING * 2) - H_GAP - 20;
			var labelHeight:Number = getElementPreferredHeight(labelDisplay) + 4;
			var labelY:Number = Math.round(0.5 * (unscaledHeight - labelHeight));

			setElementSize(labelDisplay, elementWidth, Math.min(labelHeight, 60));
			setElementPosition(labelDisplay, H_GAP + checkimageWidth, labelY);
			
			// Invailidate the size so that we can revalidate text due to potential reflow
			if (labelHeight != getElementPreferredHeight(labelDisplay) + 4)
				invalidateSize();
		}
		override public function set data(value:Object):void
		{
			if(value != null)
			{
				super.data = value;
				setCheckImage(value);
				
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods: LabelItemRenderer
		//
		//--------------------------------------------------------------------------
		
		// The message field is used to display the name of the it.  Customize its 
		// appearance by overriding its creation methods
		/*override protected function createLabelDisplay():void
		{
			labelDisplay = StyleableTextField(createInFontContext(StyleableTextField));
			labelDisplay.styleName = this;
			labelDisplay.editable = false;
			labelDisplay.selectable = false;
			labelDisplay.cacheAsBitmap = true;
			labelDisplay.multiline = true;
			labelDisplay.wordWrap = true;
			labelDisplay.lineBreak = LineBreak.TO_FIT;
			labelDisplay.styleDeclaration = styleManager.getStyleDeclaration("." + getStyle("titleStyleName"));
			
			addChild(labelDisplay);
		}
		*/
		private function editprofileClickHandler(event:MouseEvent):void
		{
			
			var newevent:customClickEvent = new customClickEvent(this.data,"editProfileEvent");
			
			owner.dispatchEvent(newevent);
			
			
		}

			


	}
}