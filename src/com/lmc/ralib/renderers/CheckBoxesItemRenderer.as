package com.lmc.ralib.renderers
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.CustomClickEvent;
	import com.lmc.ralib.model.ProfileModel;
	import com.pialabs.eskimo.controls.SkinnableAlert;
	
	import flash.desktop.Icon;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.formats.LineBreak;
	
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
	import spark.components.ToggleSwitch;
	import spark.components.supportClasses.StyleableTextField;
	import spark.core.SpriteVisualElement;
	import spark.events.ListEvent;
	import spark.utils.MultiDPIBitmapSource;
	
	//TODO 	improve the performance of the checklistboxrenderer			
	
	public class CheckBoxesItemRenderer extends IconItemRenderer
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
		
		private var inherited:Image;
		private var cm:MultiDPIBitmapSource;
		private var cb:ToggleSwitch;
		//[Bindable] public var labelField:String = "name";
		
		
		
		[Embed(source='assets/icons/groupsicon32.png')]
		private var group16:Class;
		
		[Embed(source='assets/icons/groupsicon48.png')]
		private var group24:Class;
		
		[Embed(source='assets/icons/groupsicon64.png')]
		private var group32:Class;
		
		public function CheckBoxesItemRenderer()
		{
			super();
			
			super.labelField = "name";
			//this.cacheAsBitmap = true;
			cm = new MultiDPIBitmapSource();
			cm.source160dpi = group16;
			cm.source240dpi = group24;
			cm.source320dpi = group32;
			this.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);

			
		}
		private function onDoubleClick(event:MouseEvent):void{
			// if its not inherited
			if (!data.hasparent){
				// select / deselect object
				cb.selected = !cb.selected;
				data.Status = !data.Status;
				
			}
				//we want the host to be able to switch groups no matter what
			else if(data.type == "host"){
				// select / deselect object
				cb.selected = !cb.selected;
				data.Status = !data.Status;
			}
			
			
			
		}
		private function handleClick(event:MouseEvent):void
		{
			super.data.Status = !super.data.Status;
		}
		private function inheritedClickHandler(event:MouseEvent):void
		{
			dispatchEvent(new AlertEvent(AlertEvent.OPEN, 
				"Item Inheritence", "The item belongs to the group: " + this.data.groupname, SkinnableAlert.OK,true, true));
			
		}
		
		private function setinheritedImage(item:Object):void{
			if (item.hasparent){
				inherited.source = cm.getSource(applicationDPI);
				
			}
			else{
				inherited.source = null;
				
			}
		}
		
		override protected function measure():void
		{
			var calculatedHeight:Number = getElementPreferredHeight(labelDisplay);
			var calculatedWidth:Number;
			// Check to see if the image is taller
			if (getElementPreferredHeight(inherited) + (V_PADDING * 2) > calculatedHeight)
				calculatedHeight = getElementPreferredHeight(inherited) + (V_PADDING * 2);
			
			// Round
			calculatedHeight = Math.floor(calculatedHeight);
			calculatedWidth = Math.floor(inherited.width + labelDisplay.width)
				
			measuredHeight = calculatedHeight;
			measuredWidth = calculatedWidth;
			
		} 
		override protected function createChildren():void
		{
			super.createChildren();
			if (!inherited){
				inherited = new Image();
				inherited.cacheAsBitmap = true;
				inherited.buttonMode = true;
				inherited.addEventListener(MouseEvent.CLICK, inheritedClickHandler);
				addChild(inherited);
			}
			if (!cb){
				cb = new ToggleSwitch();
				cb.cacheAsBitmap = true;
				cb.addEventListener(MouseEvent.CLICK, handleClick);
				//cb.cacheAsBitmap = true;
				addChild(cb);
			}
		}
		
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void{
			// Update styles on textFields
			labelDisplay.commitStyles();
			
			// edit button
			var cbWidth:Number = getElementPreferredWidth(cb);
			var cbHeight:Number = getElementPreferredHeight(cb);
			setElementSize(cb, cbWidth, cbHeight);
			// cbon is always right aligned, vertically centered
			var cbY:Number = Math.round(0.5 * (unscaledHeight - cbHeight));
			setElementPosition(cb, unscaledWidth - H_PADDING - cbWidth, cbY);
			
			// inherited
			var inheritedWidth:Number = getElementPreferredWidth(inherited);
			var inheritedHeight:Number = getElementPreferredHeight(inherited);
			setElementSize(inherited, inheritedWidth, inheritedHeight);
			var inheritedY:Number = Math.round(0.5 * (unscaledHeight - inheritedHeight));
			setElementPosition(inherited, H_PADDING, inheritedY);
			
			// labelDisplay
			var elementWidth:Number = unscaledWidth - (H_PADDING * 2) - H_GAP - 20;
			var labelHeight:Number = getElementPreferredHeight(labelDisplay) + 4;
			var labelY:Number = Math.round(0.5 * (unscaledHeight - labelHeight));

			setElementSize(labelDisplay, elementWidth, Math.min(labelHeight, 60));
			setElementPosition(labelDisplay, H_GAP + inheritedWidth, labelY);
			
			// Invailidate the size so that we can revalidate text due to potential reflow
			if (labelHeight != getElementPreferredHeight(labelDisplay) + 4)
				invalidateSize();
		}
		override public function set data(value:Object):void
		{
			if(value != null)
			{
				super.data = value;
				cb.selected = value.Status;
				
				// if the module belongs to a parent lets show the icon
				setinheritedImage(value);
				// Lets show the user they can't change this
				
				if (value.candeselect ){
					cb.enabled = true;
				}
				else if (value.hasparent){
					cb.enabled = false;
				}
			}
		}
		private function getLabelString(data:Object):String
		{
			if (data && data[labelField])
				return data[labelField]
			
			return null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods: LabelItemRenderer
		//
		//--------------------------------------------------------------------------
		
		// The message field is used to display the name of the it.  Customize its 
		// appearance by overriding its creation methods
		override protected function createLabelDisplay():void
		{
			super.createLabelDisplay();
			//labelDisplay = StyleableTextField(createInFontContext(StyleableTextField));
			//labelDisplay.styleName = this;
			//labelDisplay.editable = false;
			//labelDisplay.selectable = false;
			labelDisplay.cacheAsBitmap = true;
			labelDisplay.multiline = true;
			labelDisplay.wordWrap = true;
			labelDisplay.lineBreak = LineBreak.TO_FIT;
			//labelDisplay.styleDeclaration = styleManager.getStyleDeclaration("." + getStyle("titleStyleName"));
			//addChild(labelDisplay);
		}
		
		
	}
}