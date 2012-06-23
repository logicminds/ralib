package com.lmc.ralib.controller.reports
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.BusyPopupEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.model.Reports;
	import com.lmc.ralib.Events.RestClientEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetReportsResultCommand extends Command
	{
		[Inject] public var model:Reports;
		[Inject] public var event:RestClientEvent;
		public function GetReportsResultCommand()
		{
			super();
		}
		override public function execute():void{
			
			if (event.success){
				model.cloneInto(Reports(event.data));
				if ((event.data as Reports).values.length > 0){
					var resultevent:ClientResultEvent = new ClientResultEvent(ClientResultEvent.REPORTS,model);
					dispatch(resultevent);
				}
				else{
					dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "There are no reports for the given host" ));

				}
			}
		
						
		}
	}
}