package com.lmc.ralib.components
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.Events.ProfilesEvent;
	import com.lmc.ralib.model.ProfilesModel;
	import com.lmc.ralib.services.SettingsService;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	public class ProfileListMediator extends ViewMediatorBase
	{
		
		[Inject] public var list:ProfileList;
		
		public function ProfileListMediator()
		{
			
		}
		
		override public function onRegister():void
		{
			
				
				this.addContextListener(ProfilesEvent.PROFILESRESULT, onUpdate);
				dispatch(new ProfilesEvent(ProfilesEvent.GET_PROFILES_REQUEST));
		
		
			
		}
		private function onCurrentResult(event:ProfilesEvent):void{
			removeContextListener(ProfilesEvent.CURRENT_PROFILE_RESULT, onCurrentResult);

			if (event.data){
				var index:int = list.dataProvider.getItemIndex(event.data);
				list.selectedIndex = index;
			}
		}
		private function onUpdate(event:ProfilesEvent):void{
			// this occurs wheither or not data was returned
			
				this.removeContextListener(ProfilesEvent.PROFILESRESULT, onUpdate);
				list.dataProvider = (event.data as ProfilesModel).profiles;
				this.addContextListener(ProfilesEvent.CURRENT_PROFILE_RESULT, onCurrentResult);
				dispatch(new ProfilesEvent(ProfilesEvent.CURRENT_PROFILE_REQUEST));
				
		}
		
	}
}