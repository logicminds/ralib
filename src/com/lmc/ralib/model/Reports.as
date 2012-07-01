package com.lmc.ralib.model
{
	
	import com.lmc.ralib.model.ReportModel;
	public class Reports extends baseCollection
	{
		
		public function Reports(jsonObject:Object=null)
		{
			super(jsonObject);
			
		}
		public function ensureLoadmore():void{
			var loadmoreobj:ReportModel = idhash["Load More Reports"];
			// ensure the "Load More" is added to the list
			if (!loadmoreobj){
				// doesn't exist
				loadmoreobj = new ReportModel();
				loadmoreobj.host = "Load More Reports";
				idhash[loadmoreobj.host] = loadmoreobj;
			}
			else{
				//already exists place at end now
				var place:int = values.getItemIndex(loadmoreobj);
				values.removeItemAt(place);
			}
			values.addItem(loadmoreobj);

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