
package com.lmc.ralib.Events
{
	
	import mx.controls.listClasses.IListItemRenderer;
	
	import spark.events.ListEvent;
	
	
	public class CustomClickEvent extends ListEvent
	{
		public static const EDITCLICKED:String = 'customClickEvent.editclicked';
		public static const FACTCHARTCLICKED:String = 'customClickEvent.factchartclicked';


		private var _mydata:*;
		public function CustomClickEvent(type:String,data:*, bubbles:Boolean=false, cancelable:Boolean=false, 
										 columnIndex:int=-1, rowIndex:int=-1, reason:String=null, 
										 itemRenderer:IListItemRenderer=null)
		{
			super(type, bubbles, cancelable);
			
			
			_mydata = data;
			
		}
		
		public function get selecteditem():Object
		{
			return _mydata;
		}
	
	}
}