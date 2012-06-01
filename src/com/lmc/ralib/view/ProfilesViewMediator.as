package com.lmc.ralib.view
{
	import com.lmc.*;
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.components.ViewMediatorBase;
	import com.lmc.ralib.model.*;
	
	import flash.events.MouseEvent;
	
	import mx.events.CloseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;

	public class ProfilesViewMediator extends ViewMediatorBase
	{
		[Inject] public var view:ProfilesView;
		
		public function ProfilesViewMediator()
		{
			super();
		}
		override public function onRegister():void{
			
			// this is triggered by user wanting to add a profile
			eventMap.mapListener(view.delbutt,MouseEvent.CLICK, onDelete);
			
			eventMap.mapListener(view.butt_connect,MouseEvent.CLICK, onConnectClick);

		}
		
		private function onConnectClick(event:MouseEvent):void{
			if (! view.profileslist.selectedItem || view.profileslist.dataProvider.length < 1){
				// if no items
				return;
			}
			//check the connection
			this.addContextListener(ClientResultEvent.STATUS, onStatusResult);
			dispatch(new ClientRequestEvent(ClientRequestEvent.STATUS,false,null,-1,-1,view.profile));
			
			
			
			
		}
		private function onStatusResult(event:ClientResultEvent):void{
			this.removeContextListener(ClientResultEvent.STATUS, onStatusResult);
			// switch the profile if the connection is good
			if (event.data){
				this.addContextListener(ProfilesEvent.SET_CURRENT_PROFILE_RESULT, onConfirmSelectedProfile);
				// clear cache and set current profile
				dispatch(new ProfilesEvent(ProfilesEvent.SET_CURRENT_PROFILE_REQUEST, view.profileslist.selectedItem));
			}
		
		}
		private function onConfirmSelectedProfile(event:ProfilesEvent):void{
			removeContextListener(ProfilesEvent.SET_CURRENT_PROFILE_RESULT, onConfirmSelectedProfile);
			addContextListener(CloseEvent.CLOSE, onAlertClose);
			dispatch(new AlertEvent(AlertEvent.OPEN,"Notice", event.data.name + " is now the current profile"));
		}
		private function onAlertClose(event:CloseEvent):void{
			//switch views
			removeContextListener(CloseEvent.CLOSE, onAlertClose);
			dispatch(new ApplicationEvent(ApplicationEvent.LOAD_FIRST_VIEW,com.lmc.ralib.view.HomeView));
			view.navigator.popToFirstView();
		
		}
		private function onDelete(event:MouseEvent):void{
			if (view.profileslist.selectedItem){
				this.addContextListener(ProfilesEvent.REMOVED, onItemRemoval);
				dispatch(new ProfilesEvent(ProfilesViewEvent.REMOVE,view.profileslist.selectedItem ));
			}
		}
		private function onItemRemoval(event:ProfilesEvent):void{
			this.removeContextListener(ProfilesEvent.REMOVED, onItemRemoval);
			// could be annoying to popup a message everytime
			dispatch(new AlertEvent(AlertEvent.OPEN,"Notice", event.name + " profile was deleted"));

		}
	
		
		
	}
}