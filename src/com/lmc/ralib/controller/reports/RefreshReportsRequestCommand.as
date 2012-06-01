package com.lmc.ralib.controller.reports
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.model.Reports;
	
	import org.robotlegs.mvcs.Command;

	
	
	public class RefreshReportsRequestCommand extends Command
	{
		[Inject] public var model:Reports;
		[Inject] public var event:ReportsViewEvent;
		
		public function RefreshReportsRequestCommand()
		{
			super();
		}
		override public function execute():void{
			model.removeAll();
			dispatch(new ClientRequestEvent(ClientRequestEvent.REPORTS, false,event.query));


		}
	}
}