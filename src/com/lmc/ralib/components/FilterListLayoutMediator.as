package com.lmc.ralib.components
{
	import com.lmc.ralib.Events.FilterListLayoutEvent;
	
	
	import org.robotlegs.mvcs.Mediator;
	
	public class FilterListLayoutMediator extends Mediator
	{
		[Inject] public var view:FilterListlayout; 
		//[Inject] public var viewnav:ListCalloutViewNavigator;
		public function FilterListLayoutMediator()
		{
			super();
		}
		override public function onRegister():void
		{
			this.addViewListener(FilterListLayoutEvent.CLOSE, onClose);
		}
		private function onClose(event:FilterListLayoutEvent):void{
		//	dispatch(new FilterViewEvent(FilterViewEvent.GET_ITEMS_RESULT, event.data));

			view.close();
			//this.mediatorMap.removeMediatorByView(view.getElementAt(0) as ListCalloutViewNavigator);
			//this.mediatorMap.removeMediatorByView(view);
			dispatch(new FilterListLayoutEvent(FilterListLayoutEvent.CHANGE, event.data));

		}
	
	}
}