package com.lmc.ralib.controller.facts
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.Events.FactViewEvent;
	import com.lmc.ralib.Events.RestClientEvent;
	import com.lmc.ralib.components.BusyPopUp;
	import com.lmc.ralib.model.FactValues;
	
	import flash.utils.Dictionary;
	
	import org.robotlegs.mvcs.Command;
	
	public class FilterFactsByGroupCommand extends Command
	{
		[Inject] public var event:FactViewEvent;
		[Inject] public var model:FactValues;
		private var factname:String;
		public function FilterFactsByGroupCommand()
		{
			super();
		}
		public override function execute():void{
			var query:String = "";
			// cycle through list and create search query
			factname = event.factname;
		
			commandMap.detain(this);
			/// catch event and then react to filter values 
			this.eventDispatcher.addEventListener(RestClientEvent.GROUP_HOSTS,onResult);
			dispatch(new BusyPopupEvent(BusyPopupEvent.OPEN_COMPUTING));
			dispatch(new SearchEvent(SearchEvent.FIND_HOSTS_BY_GROUP,null, event.data));
		
		}
		private function onResult(event:RestClientEvent):void{
			// we now have the hosts 
			var grouphosts:Dictionary = new Dictionary()
			for each (var item:Object in event.data.values){
				grouphosts[item.name] = item;
			}
			model.grouplist = grouphosts;
			var resultevent:ClientResultEvent = new ClientResultEvent(ClientResultEvent.FACTVALUES,model);
			dispatch(resultevent);
			// filter values
			dispatch(new BusyPopupEvent(BusyPopupEvent.CLOSE_COMPUTING));

			commandMap.release(this);

		}
	}
}