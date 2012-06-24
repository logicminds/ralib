package com.lmc.ralib.controller.facts
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.Events.FactViewEvent;
	import com.lmc.ralib.Events.RestClientEvent;
	import com.lmc.ralib.components.BusyPopUp;
	import com.lmc.ralib.model.FactValues;
	import com.lmc.ralib.model.Hosts;
	
	import flash.utils.Dictionary;
	
	import org.robotlegs.mvcs.Command;
	
	public class FilterFactsByGroupCommand extends Command
	{
		[Inject] public var event:FactViewEvent;
		[Inject] public var model:FactValues;
		[Inject] public var hosts:Hosts;
		private var factname:String;
		public function FilterFactsByGroupCommand()
		{
			super();
		}
		public override function execute():void{
			var query:String = "";
			// cycle through list and create search query
			factname = event.factname;
			/// catch event and then react to filter values 
			if (event.data.length > 0){
				commandMap.detain(this);
				this.eventDispatcher.addEventListener(RestClientEvent.GROUP_HOSTS,onResult);
				dispatch(new SearchEvent(SearchEvent.FIND_HOSTS_BY_GROUP,null, event.data));

			}
			else{
				model.grouplist = hosts.namehash;
				var resultevent:ClientResultEvent = new ClientResultEvent(ClientResultEvent.FACTVALUES,model);
				dispatch(resultevent);
			}
		
		}
		private function onResult(gevent:RestClientEvent):void{
			// we now have the hosts
			this.eventDispatcher.removeEventListener(RestClientEvent.GROUP_HOSTS,onResult);
			model.grouplist = gevent.data.namehash;
			var resultevent:ClientResultEvent = new ClientResultEvent(ClientResultEvent.FACTVALUES,model);
			dispatch(resultevent);
			// filter values
			commandMap.release(this);

		}
	}
}