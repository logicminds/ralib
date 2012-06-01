package com.lmc.ralib.model
{
	import org.robotlegs.mvcs.Actor;
	
	public class DashModel extends baseModel
	{
		public var okhosts:int;
		public var activehosts:int;
		public var goodhosts:int;
		public var outofsync:int;
		public var disabledhosts:int;
		public var reportsmissing:int;
		public var percentage:int;
		public var totalhosts:int;
		public var badhosts:int;
		
		public function DashModel(jsonObject:Object=null)
		{
			super("dashboard",jsonObject);
			
		}
		public override function copy(jsonObject:Object):void{
			okhosts = jsonObject.ok_hosts;
			activehosts = jsonObject.active_hosts;
			goodhosts = jsonObject.good_hosts;
			outofsync = jsonObject.out_of_sync_hosts;
			disabledhosts = jsonObject.disabled_hosts;
			reportsmissing = jsonObject.reports_missing;
			percentage = jsonObject.percentage;
			totalhosts = jsonObject.total_hosts;
			badhosts = jsonObject.bad_hosts;
		
		}
		public function deepcopy(model:DashModel):void{
			okhosts = model.okhosts;
			activehosts = model.activehosts;
			goodhosts = model.goodhosts;
			outofsync = model.outofsync;
			disabledhosts = model.disabledhosts;
			reportsmissing = model.reportsmissing;
			percentage = model.percentage;
			totalhosts = model.totalhosts;
			badhosts = model.badhosts;
			
		}
		public override function removeAll():void{
			okhosts = 0;
			activehosts = 0;
			goodhosts = 0;
			outofsync = 0;
			disabledhosts = 0;
			reportsmissing = 0;
			percentage = 0;
			totalhosts = 0;
			badhosts = 0;
		}
	}
}