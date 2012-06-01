package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.components.ViewMediatorBase;
	
	import org.robotlegs.mvcs.Mediator;
	import com.lmc.ralib.components.FilterView;
	import com.lmc.ralib.components.FilterViewEvent;

	public class FilterViewMediator extends ViewMediatorBase
	{
		[Inject] public var view:FilterView;
		public function FilterViewMediator()
		{
			super();
		}
		override public function onRegister():void{
			addContextListener(FilterViewEvent.GET_ITEMS_REQUEST, onGetItems);
			addContextListener(FilterViewEvent.SET_ITEMS, onSetItems);
			addContextListener(ClientResultEvent.HOSTGROUPS, onGroupsResult);
			this.dispatch(new ClientRequestEvent(ClientRequestEvent.HOSTGROUPS, true));
			
		}
		private function onGetItems(event:FilterViewEvent):void{
			dispatch(new FilterViewEvent(FilterViewEvent.GET_ITEMS_RESULT, view.list.selectedItems));
		}
		private function onSetItems(event:FilterViewEvent):void{
		//	view.selected = event.selected;
		//	view.list.selectedItems = view.selected;
		}
		private function onGroupsResult(event:ClientResultEvent):void{
			view.list.dataProvider = event.data.values;
			this.removeContextListener(ClientResultEvent.HOSTGROUPS, onGroupsResult);
		//	view.list.selectedItems = view.selected;

			
		}
	}
}