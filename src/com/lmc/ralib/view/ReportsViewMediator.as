package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.components.ViewMediatorBase;
	import com.lmc.ralib.model.ReportModel;
	import com.lmc.ralib.model.Reports;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;

	public class ReportsViewMediator extends ViewMediatorBase
	{
		[Inject] public var view:ReportsView;
		private var getmore:Boolean = false;
		private var loadmoreobj:ReportModel = new ReportModel();
		
		public function ReportsViewMediator()
		{
			super();
		}
		override public function onRegister():void{
			loadmoreobj.host = "Load More Reports";
			this.addViewListener(ReportsViewEvent.QUERYEVENT, onReportsViewFilter);
			view.dispatchEvent(new ReportsViewEvent(ReportsViewEvent.QUERYEVENT, view.filter));
			this.addViewListener(ReportsViewEvent.REFRESH, onRefresh);
		}
		public function onReportsHandler(event:ClientResultEvent):void{
			removeContextListener(ClientResultEvent.REPORTS, onReportsHandler);
			var reports:Reports = event.data as Reports;
			if (getmore){
				// if the user wanted more reports
				for each (var obj:ReportModel in reports.values){
					// ensure we add next to last item
					view.list.dataProvider.addItem(obj);
				}
				getmore = false;
			}
			else{
				view.list.dataProvider = (event.data as Reports).values;
				// ensure this is added at the end
				
			}
			// ensure the "Load More" is added to the list
			if (view.list.dataProvider.length > 0){
				view.list.dataProvider.addItem(loadmoreobj);
			}
			dispatch(new BusyPopupEvent(BusyPopupEvent.CLOSE));

		}
		private function onRefresh(event:ReportsViewEvent):void{
			this.addContextListener(ClientResultEvent.REPORTS, onReportsHandler);
			dispatch(event);
		}
		private function onReportsViewFilter(event:ReportsViewEvent):void{
			this.addContextListener(ClientResultEvent.REPORTS, onReportsHandler);
			if (event.page > 1){
				// user wants more reports
				getmore = true;
			}
			dispatch(new ClientRequestEvent(ClientRequestEvent.REPORTS, event.usecache, event.query, event.resourceid, event.page));

		}
	}
}