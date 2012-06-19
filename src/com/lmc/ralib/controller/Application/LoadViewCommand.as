package com.lmc.ralib.controller.Application
{
	import com.lmc.ralib.Events.ChangeViewEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.model.Bookmarks;
	import com.lmc.ralib.view.FactSystemsView;
	
	import mx.core.FlexGlobals;
	
	import org.robotlegs.mvcs.Command;
	
	import spark.components.ViewNavigator;
	import spark.components.supportClasses.ViewNavigatorBase;
	
	public class LoadViewCommand extends Command
	{
		[Inject] public var event:ChangeViewEvent;
		[Inject] public var bookmarks:Bookmarks;
		private var navs:Vector.<ViewNavigatorBase>;
		
		public function LoadViewCommand()
		{
			super();
		}
		public override function execute():void{
			if (FlexGlobals.topLevelApplication.hasOwnProperty('navigators')){
				navs = FlexGlobals.topLevelApplication.navigators;
			}
			else{
				navs = FlexGlobals.topLevelApplication.tabnavigators.navigators;
			}
			this.commandMap.detain(this);
			this.eventDispatcher.addEventListener(ClientResultEvent.HOSTS, onResult);
			var query:String;
			if (event.query){
				query = event.query;
			}
			else{
				query = event.bookmark.query;
			}
			
			dispatch(new ClientRequestEvent(ClientRequestEvent.HOSTS, false, query));
		}
		private function onResult(resultevent:ClientResultEvent):void{
			this.eventDispatcher.removeEventListener(ClientResultEvent.HOSTS, onResult);
			ViewNavigator(navs[event.navid]).pushView(event.view, {hosts: resultevent.data.values});
			this.commandMap.release(this);


		}
	}
}