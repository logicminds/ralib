package com.lmc.ralib.controller.dashboard
{
	import com.lmc.ralib.Events.BusyPopupEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.model.DashModel;
	import com.lmc.ralib.model.ProfilesModel;
	import com.lmc.ralib.Events.RestClientEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetDashboardResultCommand extends Command
	{
		[Inject] public var event:RestClientEvent;
		[Inject] public var model:DashModel;
		public function GetDashboardResultCommand()
		{
			super();
		}
		override public function execute():void{
			if (event.success){
				model.deepcopy(event.data); 
				var resultevent:ClientResultEvent = new ClientResultEvent(ClientResultEvent.DASHBOARD,model);
				dispatch(resultevent);
			}
						
		}
	}
}