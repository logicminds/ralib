
package com.lmc.ralib.Events
{
	
	import mx.controls.listClasses.IListItemRenderer;
	import spark.events.ListEvent;
	
	
	public class customClickEvent extends ListEvent
	{
		public static const EDITCLICKED:String = 'customClickEvent.editclicked';

		private var _mydata:*;
		public function customClickEvent(data:*,type:String, bubbles:Boolean=false, cancelable:Boolean=false, 
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