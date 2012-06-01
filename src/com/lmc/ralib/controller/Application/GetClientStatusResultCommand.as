package com.lmc.ralib.controller.Application
{
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.model.AppKeeper;
	import com.lmc.ralib.Events.RestClientEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetClientStatusResultCommand extends Command
	{
		[Inject] public var event:RestClientEvent;
		[Inject] public var appkeeper:AppKeeper;
		public function GetClientStatusResultCommand()
		{
			super();
		}
		public override function execute():void{
			if (event.success){
				dispatch(new ClientResultEvent(ClientResultEvent.STATUS, event.data));
			}
		}
	}
	
}