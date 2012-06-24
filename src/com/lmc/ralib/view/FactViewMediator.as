package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.Events.FilterListLayoutEvent;
	import com.lmc.ralib.Events.MenuEvent;
	import com.lmc.ralib.components.ViewMediatorBase;
	import com.lmc.ralib.model.FactValues;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class FactViewMediator extends ViewMediatorBase
	{
		[Inject] public var view:FactView;
		[Inject] public var factvalues:FactValues;
		
		public function FactViewMediator()
		{
			super();
		}
		override public function onRegister():void{
			view.showBusy();
			addContextListener(MenuEvent.RESULT_FACT_MENU, onMenuHandler);
			addContextListener(FilterListLayoutEvent.CHANGE, onFilterChange );

			addViewListener(FilterListLayoutEvent.OPEN, dispatch);
			addViewListener(FactViewEvent.FILTERHOSTGROUPS, onFilterRequest);
			addViewListener(FactViewEvent.CREATE_FACT_EMAIL, dispatch);
			// get facts
			if (factvalues.values.length < 1){
				addContextListener(ClientResultEvent.FACTVALUES, onGetFactValues);
				dispatch(new ClientRequestEvent(ClientRequestEvent.FACTVALUES,false, view.query));
			}
			else{
				addContextListener(ClientResultEvent.FACTVALUES, onFactValues);
				dispatch(new FactViewEvent(FactViewEvent.FILTERHOSTGROUPS, view.hostgroups, view.data.fact.name,true));	
			}
			
			
			//addContextListener(ClientResultEvent.FACTVALUES, onFactValues);
			//dispatch(new FactViewEvent(FactViewEvent.FILTERHOSTGROUPS, view.hostgroups, view.data.fact.name,true));
			
			dispatch(new MenuEvent(MenuEvent.GET_FACT_MENU));
			dispatch(new AnalyticsTrackerEvent(AnalyticsTrackerEvent.TRACKPAGEVEW, "/facts/values -RL"));
		}
		private function onGetFactValues(event:ClientResultEvent):void{
			removeContextListener(ClientResultEvent.FACTVALUES, onGetFactValues);
			addContextListener(ClientResultEvent.FACTVALUES, onFactValues);
			dispatch(new FactViewEvent(FactViewEvent.FILTERHOSTGROUPS, view.hostgroups, view.data.fact.name,true));	
		}
		private function onFilterRequest(event:FactViewEvent):void{
			view.showBusy();
			this.addContextListener(ClientResultEvent.FACTVALUES, onFactValues);
			dispatch(event);
		}
		private function onFilterChange(event:FilterListLayoutEvent):void{
			view.dispatchEvent(event);
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