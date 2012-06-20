package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.Events.FilterListLayoutEvent;
	import com.lmc.ralib.Events.MenuEvent;
	import com.lmc.ralib.components.ViewMediatorBase;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class FactViewMediator extends ViewMediatorBase
	{
		[Inject] public var view:FactView;
		
		public function FactViewMediator()
		{
			super();
		}
		override public function onRegister():void{
			view.showBusy();
			this.addContextListener(MenuEvent.RESULT_FACT_MENU, onMenuHandler);
			onActivate();
			this.addViewListener(FactViewEvent.FACTVALUES, onActivate);
			this.addViewListener(FilterListLayoutEvent.OPEN, dispatch);
			this.addContextListener(FilterListLayoutEvent.CHANGE, onFilterChange );
			this.addViewListener(FactViewEvent.FILTERHOSTGROUPS, onFilterRequest);
			this.addViewListener(FactViewEvent.CREATE_FACT_EMAIL, dispatch);
			dispatch(new MenuEvent(MenuEvent.GET_FACT_MENU));
			dispatch(new AnalyticsTrackerEvent(AnalyticsTrackerEvent.TRACKPAGEVEW, "/facts/values -RL"));
		}
		private function onFilterRequest(event:FactViewEvent):void{
			view.showBusy();
			this.addContextListener(ClientResultEvent.FACTVALUES, onFactValues);
			dispatch(event);
		}
		private function onFilterChange(event:FilterListLayoutEvent):void{
			view.dispatchEvent(event);
		}
	
		private function onActivate():void{

			this.removeViewListener(FactViewEvent.FACTVALUES, onActivate);
			// get fact values
			this.addContextListener(ClientResultEvent.FACTVALUES, onFactValues);
			dispatch(new ClientRequestEvent(ClientRequestEvent.FACTVALUES,false, view.query));
		}
		private function onFactValues(event:ClientResultEvent):void{
			this.removeContextListener(ClientResultEvent.FACTVALUES, onFactValues);
			view.values = event.data.values;
			view.closeBusy();

		
		}
		private function onMenuHandler(event:MenuEvent):void{
			this.removeContextListener(MenuEvent.RESULT_FACT_MENU, onMenuHandler);
			//view.list.dataProvider = event.data;
		}

	}
}