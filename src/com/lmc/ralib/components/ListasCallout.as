package com.lmc.ralib.components
{
	
	import flash.events.MouseEvent;
	
	import mx.events.IndexChangedEvent;
	
	import spark.components.Button;
	import spark.components.Callout;
	import spark.components.HGroup;
	import spark.components.List;
	import spark.components.VGroup;
	import spark.events.IndexChangeEvent;
	
	public class ListasCallout extends Callout
	{
		[Bindable] public var retData:*;
		public var list:spark.components.List;
		private var vgroup:VGroup;
		private var hgroup:HGroup;
		private var button:Button;
		public function ListasCallout()
		{
			super();
			list = new List();
			list.labelField = "label";
			list.percentHeight = 100;
			list.percentWidth =  100;
			list.addEventListener(IndexChangeEvent.CHANGE, onChange);
			vgroup = new VGroup();
			hgroup = new HGroup();
			button = new Button();
			button.label = "Close";
			button.addEventListener(MouseEvent.CLICK, clickHandler);
			vgroup.percentHeight = 100;
			vgroup.percentWidth = 100;
			vgroup.gap = 10;
			vgroup.paddingBottom = 10;
			hgroup.percentWidth = 100;
			hgroup.horizontalAlign = "center";
			hgroup.addElement(button);
			vgroup.addElement(list);
			vgroup.addElement(hgroup);
			this.addElement(vgroup);
			
		}
		protected function onChange(event:IndexChangeEvent):void{
			retData = list.selectedItem;
		}
		// Event handler for the click event of the OK button.
		protected function clickHandler(event:MouseEvent):void {
			//Create the return data.
			retData = list.selectedItem
			
			// Close the Callout.
			// Set the commit argument to true to indicate that the 
			// data argument contains a valid value.
			close(true, retData);
		}
	}
}