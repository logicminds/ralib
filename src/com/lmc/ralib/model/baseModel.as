package com.lmc.ralib.model
{
	import org.robotlegs.mvcs.Actor;

	public class baseModel extends Actor
	{
		public var name:String = "";
		public var id:int;
		protected var _type:String;
		public var properties:Object;
		
		public function baseModel( type:String,jsonObject:Object=null)
		{
			super();
			this._type = type;
			if (jsonObject){
				copy(jsonObject);
			}
			
			
		}
		public function copy(jsonObject:Object):void{
			
		}
		public function removeAll():void{
			
		}
			
		
		
		
	}
}