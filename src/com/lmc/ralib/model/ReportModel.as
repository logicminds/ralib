package com.lmc.ralib.model
{
	import org.robotlegs.mvcs.Actor;
	
	public class ReportModel extends baseModel
	{
		public var summary:String = "";
		public var host:String = "";
		public var status:Object;
		public var reported_at:String = "";
		public var metrics:Object;
		public var logs:Array;
		
		public function ReportModel(jsonObject:Object=null):void
		{
			super("ReportModel", jsonObject);
		}
		public override function copy(jsonObject:Object):void{
			summary = jsonObject.summary;
			host = jsonObject.host;
			status = jsonObject.status;
			reported_at = jsonObject.reported_at;
			id = jsonObject.id;
			metrics = jsonObject.metrics;
			logs = jsonObject.logs;
			
		}
	}
}