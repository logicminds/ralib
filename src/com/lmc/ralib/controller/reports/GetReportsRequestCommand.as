package com.lmc.ralib.controller.reports
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.model.Reports;
	import com.lmc.ralib.services.RemoteServiceBase;
	
	import org.robotlegs.mvcs.Command;

	
	
	public class GetReportsRequestCommand extends Command
	{
		[Inject] public var model:Reports;
		[Inject] public var event:ClientRequestEvent;
		[Inject] public var remoteclient:RemoteServiceBase;
		public function GetReportsRequestCommand()
		{
			super();
		}
		override public function execute():void{
			// check the cache first
			if (model.values.length > 0 && event.usecache == true){
				var resultevent:ClientResultEvent = new ClientResultEvent(ClientResultEvent.REPORTS, model);
				dispatch(resultevent);
				return;
			}
			if (remoteclient.type()){
				
				remoteclient.getreports(event.page, event.resourceid, event.query);
			
			}
			else{
				dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "No Connection Profile is Selected"));
			}
		}
	}
}