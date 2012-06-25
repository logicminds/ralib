package com.lmc.ralib.controller.Application
{
	import com.lmc.ralib.Events.ChangeViewEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ClientResultEvent;
	import com.lmc.ralib.model.Bookmarks;
	import com.lmc.ralib.view.FactSystemsView;
	import com.lmc.ralib.view.HostsView;
	
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
			var viewdata:Object; 
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
			if (event.data){
				viewdata = event.data;
			}
			else{
				viewdata = new Object();
			}
			if (event.query){
				viewdata.query = event.query;
			}
			else if (event.bookmark){
				viewdata.query = event.bookmark.query;
			}
			//load view
			ViewNavigator(navs[event.navid]).pushView(event.view, viewdata);

			//switch navs
			TabbedViewNavigator(navs[0].parentNavigator).selectedIndex = event.navid;
		}
		
	}
}