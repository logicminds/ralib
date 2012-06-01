package com.lmc.ralib.controller.classes
{
	import com.lmc.ralib.model.PuppetClasses;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.Events.RestClientEvent;
	import org.robotlegs.mvcs.Command;
	
	public class GetClassesResultCommand extends Command
	{
		[Inject] public var model:PuppetClasses;
		[Inject] public var event:RestClientEvent;
		
		public function GetClassesResultCommand()
		{
			super();
		}
		public override function execute():void{
			if (event.success){
				model.cloneInto(event.data);
				var resultevent:ClientResultEvent = new ClientResultEvent(ClientResultEvent.PUPPETCLASSES,model);
				dispatch(resultevent);
			}
		}
	}
}