package com.lmc.ralib.view
{
	import com.lmc.ralib.components.ViewMediatorBase;
	import com.lmc.ralib.model.Host;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class HostPropertiesViewMediator extends ViewMediatorBase
	{
		[Inject] public var view:HostPropertiesView;
		public function HostPropertiesViewMediator()
		{
			super();
		}
		public override function onRegister():void{
			view.list.dataProvider = (view.data.host as Host).hostproperties;
		}
	}
}