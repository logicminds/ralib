package com.lmc.ralib.components.charts
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.model.Bookmarks;
	import com.lmc.ralib.model.DashModel;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	
	public class DashBoardOverViewMediator extends Mediator
	{
		[Inject] public var bookmarks:Bookmarks;
		[Inject] public var view:DashBoardOverView;

		public function DashBoardOverViewMediator()
		{
			super();
		}
		override public function onRegister():void{
			this.addViewListener(ClientRequestEvent.DASHBORAD, onRefresh);
			this.addContextListener(ClientResultEvent.DASHBOARD, onDataLoad);

			dispatch(new ClientRequestEvent(ClientRequestEvent.DASHBORAD));
			addViewListener(ChangeViewEvent.LOAD_VIEW, dispatch);
			view.bookmarks = bookmarks;

		}
		private function onRefresh(event:ClientRequestEvent):void{
			this.addContextListener(ClientResultEvent.DASHBOARD, onDataLoad);
			dispatch(event);

		}
		private function onDataLoad(event:ClientResultEvent):void{
			this.removeContextListener(ClientResultEvent.DASHBOARD, onDataLoad);
			view.dataProvider = event.data as DashModel;

		}
	}
}