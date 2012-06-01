package com.lmc.ralib.controller.reports
{
	import com.lmc.ralib.Events.ReportsViewEvent;
	import com.lmc.ralib.model.ReportModel;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.utils.ObjectUtil;
	
	import org.robotlegs.mvcs.Command;
	
	public class ParseReportCommand extends Command
	{
		[Inject] public var event:ReportsViewEvent;
		public function ParseReportCommand()
		{
			super();
		}
		public override function execute():void{
			    var logs:ArrayCollection = new ArrayCollection();
			    var metrics:ArrayCollection = new ArrayCollection();
			    var timemetrics:ArrayCollection = new ArrayCollection();
				var report:ReportModel = event.report as ReportModel;
				var logview:String = new String();
				var metric:Object = event.report.metrics;
				
				// this will get the logs for the textarea
				if ( ! report.logs || report.logs.length == 0){
					logview = "No Logs are Available";
					
				}
					
				else{
					for each (var log:Object in report.logs){
						
						logview +="Source: " + log.log.sources.source + "\n";
						logview += "Message: " + log.log.messages.message + "\n\n";
						//logs.addItem({source: log.log.sources.source, message: log.log.messages.message});
						
					}
				}
				// use introspection to get the data dynamically
				// there can be many types!  So we don't know in advance
				var i:int=0;
				var timetype:Object = ObjectUtil.getClassInfo(metric.time);
				var name:String;
				var total:Number = metric.time.total;
				var percent:Number;
				var time:Number;
				
				// calculate percentages
				for each (var data:Number in metric.time){
					name = timetype.properties[i].toString();
					time = metric.time[name];
					percent = Number((Number(time) / Number(total))) * 100;
					timemetrics.addItem({label:name, time: time, total:total, percent: percent });
					i++;
				}
				// sort by percent
				var timesort:Sort = new Sort();
				var sortField:SortField = new SortField('percent', false, true);
				timesort.fields = [sortField];
				timemetrics.sort = timesort;
				timemetrics.refresh();
				
				
				if (metric.hasOwnProperty("changes")){
					metrics.addItem({label: "Changes", value:metric.changes.total});
					
				}
				if (metric.hasOwnProperty("events")){
					metrics.addItem({name: "Events", value:metric.events.total});
					
				}
				if ( metric.hasOwnProperty("resources")){
					metrics.addItem({name: "Resources", value: metric.resources.total});
					
				}
				// this will get the metrics not time related for a graph
			var reportobj:Object = new Object();
			reportobj.timemetrics = timemetrics;
			reportobj.metrics = metrics;
			reportobj.logview = logview;
			dispatch(new ReportsViewEvent(ReportsViewEvent.PARSE_REPORT_RESULT,null,-1,1,false,event.report,reportobj));
		}
	}
}