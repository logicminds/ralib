package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.components.ViewMediatorBase;
	import com.lmc.ralib.model.*;
	import com.lmc.ralib.Events.RestClientEvent;
	import com.pialabs.eskimo.controls.SkinnableAlert;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.utils.ObjectUtil;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.PopUpEvent;
	
	import com.lmc.ralib.utils.LogicMindsUtils;

	public class ProfileViewMediator extends ViewMediatorBase
	{

		[Inject] public var view:ProfileView;
		
		public function ProfileViewMediator()
		{
			super();
		}
		override public function onRegister():void{
			this.eventMap.mapListener(view, ClientRequestEvent.STATUS, onCheckStatus);
			this.addContextListener(ProfilesEvent.ADDED, onAdded);
			this.addContextListener(ProfilesEvent.UPDATED, onAdded);
			addViewListener(DialogPopUpEvent.OPEN_USERPASS, openpassbox);

		}
		private function onCheckStatus(event:ClientRequestEvent):void{
			this.addContextListener(ClientResultEvent.STATUS, onStatusResult);
			dispatch(event);
		}
		
		private function openpassbox(event:DialogPopUpEvent):void{
			this.addContextListener(PopUpEvent.CLOSE, onUserPassInput);
			dispatch(event);
		}
		private function onUserPassInput(event:PopUpEvent):void{
			this.removeContextListener(PopUpEvent.CLOSE, onUserPassInput);
			// test credentials
			if (event.data){
				view.profile.setcredentials(event.data.username, event.data.password);
			}
		}
		private function onStatusResult(event:ClientResultEvent):void{
			// this checks the connection
			this.removeContextListener(ClientResultEvent.STATUS, onStatusResult);
			if (event.data){
				if (event.data.version){
					view.profile.clientversion = event.data.version;
				}
				// save or update after verifiying 
				dispatch(new ProfilesEvent(ProfilesEvent.ADD_REQUEST, view.profile));
			}
			
		}
	
		private function onAlertClose(event:CloseEvent):void{
			removeContextListener(CloseEvent.CLOSE, onAlertClose);

			view.navigator.popView();

		}
		private function onAdded(event:ProfilesEvent):void{
			this.addContextListener(CloseEvent.CLOSE, onAlertClose);

			switch(event.type){
				case ProfilesEvent.ADDED:
					dispatch(new AlertEvent(AlertEvent.OPEN,"Notice", event.data.name + " profile was added"));
					break;
				case ProfilesEvent.UPDATED:
					dispatch(new AlertEvent(AlertEvent.OPEN,"Notice",event.data.name + " profile was updated"));
					break;
			}

		}
		
		
	}
}