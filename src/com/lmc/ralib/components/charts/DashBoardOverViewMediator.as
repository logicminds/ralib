package com.lmc.ralib.components.charts
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.model.DashModel;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	public class DashBoardOverViewMediator extends Mediator
	{
		[Inject] public var view:DashBoardOverView;

		public function DashBoardOverViewMediator()
		{
			super();
		}
		override public function onRegister():void{
			this.addContextListener(ClientResultEvent.DASHBOARD, onDataLoad);
			this.addViewListener("RefreshDashboardEvent", onRefresh);
			dispatch(new ClientRequestEvent(ClientRequestEvent.DASHBORAD));
			
		}
		private function onRefresh(event:Event):void{
			this.addViewListener("RefreshDashboardEvent", onRefresh);
			dispatch(new ClientRequestEvent(ClientRequestEvent.DASHBORAD,false));

		}
		private function onDataLoad(event:ClientResultEvent):void{
			this.removeContextListener(ClientResultEvent.DASHBOARD, onDataLoad);
			view.dataProvider = event.data as DashModel;

		}
	}
}