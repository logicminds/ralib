package com.lmc.ralib.controller.hosts
{
	import com.lmc.ralib.model.Hosts;
	import com.lmc.ralib.model.ProfilesModel;
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.Events.RestClientEvent;
	import org.robotlegs.mvcs.Command;
	
	public class GetHostsResultCommand extends Command
	{
		[Inject] public var model:Hosts;
		[Inject] public var event:RestClientEvent;
		
		public function GetHostsResultCommand()
		{
			super();
		}
		override public function execute():void{
			if (event.success){
				model.cloneInto(event.data);
				var resultevent:ClientResultEvent = new ClientResultEvent(ClientResultEvent.HOSTS,model);
				dispatch(resultevent);
			}			
		}
		
	}
}