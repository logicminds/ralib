package com.lmc.ralib.components
{
	import com.lmc.ralib.Events.FilterListLayoutEvent;
	
	
	import org.robotlegs.mvcs.Mediator;
	
	public class FilterListLayoutMediator extends Mediator
	{
		[Inject] public var view:FilterListlayout; 
		public function FilterListLayoutMediator()
		{
			super();
		}
		override public function onRegister():void
		{
			this.addViewListener(FilterListLayoutEvent.CHANGE, dispatch);
		}
		
	
	}
}