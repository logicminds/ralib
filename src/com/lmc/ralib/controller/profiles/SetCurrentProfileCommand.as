package com.lmc.ralib.controller.profiles
{
	import com.lmc.ralib.Events.ApplicationEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.ProfilesEvent;
	import com.lmc.ralib.model.AppKeeper;
	import com.lmc.ralib.model.ProfilesModel;
	import com.lmc.ralib.services.RemoteService;
	import com.lmc.ralib.services.RemoteServiceBase;
	
	import flash.desktop.NativeApplication;
	import flash.display.DisplayObjectContainer;
	
	import mx.core.FlexGlobals;
	
	import org.robotlegs.mvcs.Command;
	
	import spark.components.TabbedViewNavigator;
	import spark.components.ViewNavigator;
	import spark.components.supportClasses.ViewNavigatorBase;
	
	public class SetCurrentProfileCommand extends Command
	{
		[Inject] public var model:ProfilesModel;
		[Inject] public var event:ProfilesEvent;
		[Inject] public var remoteservice:RemoteService;
		[Inject] public var appkeeper:AppKeeper;
		
		public var remoteclient:RemoteServiceBase;
		
		public function SetCurrentProfileCommand()
		{
			super();
		}
		override public function execute():void{
			if (model.currentprofile != event.data){
				// move all navigators to first view
				var navs:Vector.<ViewNavigatorBase>;
				if (FlexGlobals.topLevelApplication.hasOwnProperty('navigators')){
					navs = FlexGlobals.topLevelApplication.navigators;
				}
				else{
					navs = FlexGlobals.topLevelApplication.tabnavigators.navigators;
				}
				for each (var nav:ViewNavigatorBase in navs){
					if (nav.label == "More"){
						continue;
					}
					ViewNavigator(nav).popToFirstView();
				}
				
			}
			model.currentprofile = event.data;
			// Create the Remote Service Ojbect and manually inject it
			if (model.currentprofile){
				this.injector.unmap(RemoteServiceBase);
				remoteclient = remoteservice.getService(model.currentprofile);
				appkeeper.clienttype = model.currentprofile.clienttype.name;
				this.injector.injectInto(remoteclient);
				this.injector.mapValue(RemoteServiceBase, remoteclient);
				dispatch(new ClientRequestEvent(ClientRequestEvent.HOSTS,false));
				dispatch(new ClientRequestEvent(ClientRequestEvent.BOOKMARKS,false));


			}
			dispatch(new ApplicationEvent(ApplicationEvent.CLEAR_CACHE_REQUEST));
			dispatch(new ProfilesEvent(ProfilesEvent.SET_CURRENT_PROFILE_RESULT, model.currentprofile));
		}
	}
}