package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.ReportsViewEvent;
	import com.lmc.ralib.components.ViewMediatorBase;
	
	
	public class ReportViewMediator extends ViewMediatorBase
	{
		[Inject] public var view:ReportView;
		public function ReportViewMediator()
		{
			super();
		}
		override public function onRegister():void{
			
			addContextListener(ReportsViewEvent.PARSE_REPORT_RESULT, onResult);
			dispatch(new ReportsViewEvent(ReportsViewEvent.PARSE_REPORT, null, -1, 1,false,view.data.report));
		}
		private function onResult(event:ReportsViewEvent):void{
			removeContextListener(ReportsViewEvent.PARSE_REPORT_RESULT, onResult);
			view.Providers = event.data;
			view.logarea.text = event.data.logview;
		}
	}
}