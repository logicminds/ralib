package com.lmc.ralib.controller.Application
{
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.Events.RestClientEvent;
	import com.lmc.ralib.model.Bookmarks;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetClientBookmarksResultCommand extends Command
	{
		[Inject] public var event:RestClientEvent;
		[Inject] public var model:Bookmarks;
		
		public function GetClientBookmarksResultCommand()
		{
			super();
		}
		public override function execute():void{
			model.cloneInto(event.data);
			dispatch(new ClientResultEvent(ClientResultEvent.BOOKMARKS, event.data));
		}
	}
}