package com.lmc.ralib.controller.Application
{
	import com.lmc.ralib.Events.ChangeViewEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.model.Bookmarks;
	import com.lmc.ralib.view.FactSystemsView;
	
	import mx.core.FlexGlobals;
	
	import org.robotlegs.mvcs.Command;
	
	import spark.components.TabbedViewNavigator;
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
			//var t:* = FlexGlobals.topLevelApplication;
			if (FlexGlobals.topLevelApplication.hasOwnProperty('navigators')){
				//desktop app
				navs = FlexGlobals.topLevelApplication.navigators;

			}
			else{
				//mobile app
				navs = FlexGlobals.topLevelApplication.tabnavigators.navigators;

			}
			var query:String;
			if (event.query){
				query = event.query;
			}
			else{
				query = event.bookmark.query;
			}
			//load view
			ViewNavigator(navs[event.navid]).pushView(event.view, {query:query});
			//switch navs
			TabbedViewNavigator(navs[0].parentNavigator).selectedIndex = event.navid;
		}
		
	}
}