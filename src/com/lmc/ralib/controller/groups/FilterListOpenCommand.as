package com.lmc.ralib.controller.groups
{
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.Events.FilterListLayoutEvent;
	import com.lmc.ralib.components.FilterListlayout;
	import com.lmc.ralib.components.FilterView;
	import com.lmc.ralib.components.FilterViewEvent;
	import com.lmc.ralib.components.ListCalloutViewNavigator;
	import com.lmc.ralib.components.ListasCallout;
	import com.lmc.ralib.model.AppKeeper;
	import com.lmc.ralib.model.HostGroups;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Command;
	
	public class FilterListOpenCommand extends Command
	{
		[Inject] public var event:FilterListLayoutEvent;
		[Inject] public var hostgroups:HostGroups;
		private var filtercallout:FilterListlayout;
		
		public function FilterListOpenCommand()
		{
			super();
		}
		private function openCallout():void{
			if (mediatorMap.hasMediatorForView(FilterListlayout)){
				trace("filterlayout already showing");
				return;
			}
			filtercallout = new FilterListlayout();
			this.mediatorMap.createMediator(filtercallout);
			filtercallout.items = hostgroups.values;
			filtercallout.open(event.owner as DisplayObjectContainer, true);
			filtercallout.selected = event.data;
		}
		private function onResult(event:ClientResultEvent):void{
			this.eventDispatcher.removeEventListener(ClientResultEvent.HOSTGROUPS, onResult);
			openCallout();
			commandMap.release(this);
		}
		override public function execute():void{
			this.commandMap.detain(this);
			if (hostgroups.values.length < 1){
				this.eventDispatcher.addEventListener(ClientResultEvent.HOSTGROUPS, onResult);
				dispatch(new ClientRequestEvent(ClientRequestEvent.HOSTGROUPS, true));
			}
			else{
				openCallout();
			}
			
			
		}
	}
}