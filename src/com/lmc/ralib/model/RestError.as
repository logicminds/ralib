package com.lmc.ralib.model
{
	import mx.utils.ObjectUtil;

	public class RestError extends baseModel
	{
		public var message:String;
		public function RestError(jsonObject:Object=null)
		{
			super("Error", jsonObject);
		}
		public override function copy(jsonObject:Object):void{
			
			var errorsection:String = ObjectUtil.getClassInfo(jsonObject.errors).properties[0];
			var mesarray:Array = jsonObject.errors[errorsection];
			message = errorsection  + " error: " + mesarray[0];
			trace(jsonObject);
			
		}
		
	}
}