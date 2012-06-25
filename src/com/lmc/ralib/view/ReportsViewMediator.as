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
		
		public function ReportsViewMediator()
		{
			super();
		}
		override public function onRegister():void{
			onRefresh(new ClientRequestEvent(ClientRequestEvent.REPORTS,view.usecache,view.filter));
			addViewListener(ClientRequestEvent.REPORTS, onRefresh);
			addViewListener(ReportsViewEvent.QUERYEVENT, onReportsViewFilter);
		}
		public function onReportsHandler(event:ClientResultEvent):void{
			removeContextListener(ClientResultEvent.REPORTS, onReportsHandler);
			var reports:Reports = Reports(event.data);
			reports.ensureLoadmore();

			if (getmore){
				// if the user wanted more reports
				for each (var obj:Object in reports.values){
					// ensure we add next to last item
					view.reports.addItem(obj);
				}
				getmore = false;
			}
			else{
				view.reports.source = reports.values.source;
				
			}
			dispatch(new BusyPopupEvent(BusyPopupEvent.CLOSE));

		}
		private function onRefresh(event:ClientRequestEvent):void{
			view.reports.removeAll();
			addContextListener(ClientResultEvent.REPORTS, onReportsHandler);
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