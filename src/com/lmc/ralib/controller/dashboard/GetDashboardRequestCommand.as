package com.lmc.ralib.controller.dashboard
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.model.DashModel;
	import com.lmc.ralib.model.Hosts;
	import com.lmc.ralib.services.RemoteServiceBase;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetDashboardRequestCommand extends Command
	{
		[Inject] public var event:ClientRequestEvent;
		[Inject] public var remoteclient:RemoteServiceBase;
		[Inject] public var model:DashModel;
		public function GetDashboardRequestCommand()
		{
			super();
		}
		override public function execute():void{
			// check the cache first
			if (model.totalhosts && event.usecache == true){
				var resultevent:ClientResultEvent = new ClientResultEvent(ClientResultEvent.DASHBOARD, model);
				dispatch(resultevent);
				return;
			}
			if (remoteclient.type()){
				
				remoteclient.getdashboard();
			}
			else{
				dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "No Connection Profile is Selected"));
			}
		}
	}
}