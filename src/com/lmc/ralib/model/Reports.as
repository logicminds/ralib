package com.lmc.ralib.model
{
	
	import com.lmc.ralib.model.ReportModel;
	public class Reports extends baseCollection
	{
		
		public function Reports(jsonObject:Object=null)
		{
			super(jsonObject, "Reports");
			
		}
		public override function copy(jsonObject:Object):Boolean{
			//values.source = jsonObject as Array;
			// I don't think its worth the time to process each report as a special report object
			for each (var obj:Object in jsonObject){
				var report:ReportModel = new ReportModel(obj.report);
				values.addItem(report);
				idhash[report.id] = report;
			}
			return true;
		}
		
	}
}