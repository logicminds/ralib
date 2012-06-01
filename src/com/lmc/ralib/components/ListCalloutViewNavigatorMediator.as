package com.lmc.ralib.components
{
	import com.lmc.ralib.Events.FilterListLayoutEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ListCalloutViewNavigatorMediator extends ViewMediatorBase
	{
		[Inject] public var view:ListCalloutViewNavigator;
		public function ListCalloutViewNavigatorMediator()
		{
			super();
		}
		public override function onRegister():void{
			mediatorMap.createMediator(view.activeView);
			this.addContextListener(FilterViewEvent.GET_ITEMS_RESULT, onItemsResult)
			this.eventMap.mapListener(view, FilterViewEvent.SET_ITEMS, dispatch);
			this.eventMap.mapListener(view, FilterViewEvent.GET_ITEMS_REQUEST, dispatch);
			//this.addContextListener(FilterViewEvent.SET_ITEMS, dispatch);
		}
		private function onItemsResult(event:FilterViewEvent):void{
			dispatch(new FilterListLayoutEvent(FilterListLayoutEvent.CLOSE, event.selected));
		}
		
	}
}