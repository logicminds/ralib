package com.lmc.ralib.controller.Application
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.model.Bookmarks;
	import com.lmc.ralib.services.RemoteServiceBase;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetClientBookmarksCommand extends Command
	{
		[Inject] public var event:ClientRequestEvent;
		[Inject] public var remoteclient:RemoteServiceBase
		[Inject] public var model:Bookmarks;
		
		public function GetClientBookmarksCommand()
		{
			super();
		}
		public override function execute():void{
			// check the cache first
			if (model.values.length > 0 && event.usecache == true){
				var resultevent:ClientResultEvent = new ClientResultEvent(ClientResultEvent.BOOKMARKS, model );
				dispatch(resultevent);
				return;
			}
			if (remoteclient.type()){
				remoteclient.getBookmarks();
			}
			else{
				dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", "No Connection Profile is Selected"));
			}
		}
	}
}