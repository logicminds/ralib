package com.lmc.ralib.model
{
	import com.lmc.ralib.Events.ProfilesEvent;
	import com.lmc.ralib.Events.SettingsServiceEvent;
	import com.lmc.ralib.model.ProfileModel;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Actor;

	[RemoteClass(alias="com.lmc.ralib.model.ProfilesModel")]
	public class ProfilesModel extends Actor
	{
		
		private var _currentprofile:ProfileModel;
		[Bindable] private var _profiles:ArrayCollection;
		private var _namehash:Dictionary;
		
		public function set currentprofile(profile:ProfileModel):void{
			// unset the current and set the new current profile
			if (_currentprofile){
				_currentprofile.currentprofile = false;
			}
			
			if (profile){
				profile.currentprofile = true;
				_currentprofile = profile;
				
			}
			dispatch(new SettingsServiceEvent(SettingsServiceEvent.WRITE_REQUEST,"profiles",this));
		}
		public function get currentprofile():ProfileModel{
			if (_currentprofile == null && _profiles.length == 1){
				currentprofile = _profiles.getItemAt(0) as ProfileModel;
			}
			return _currentprofile;
			
		}
		public function ProfilesModel()
		{
			super();
			_profiles = new ArrayCollection();
			_namehash = new Dictionary();
			
		}
		public function get namehash():Dictionary{
			return _namehash;
		}
		public function set namehash(namehash:Dictionary):void{
			_namehash = namehash;
		}
		public function get profiles():ArrayCollection{
			return _profiles;
		}
		public function set profiles(ac:ArrayCollection):void{
			_profiles = ac;
		}
		public function addProfile(profile:ProfileModel):void{
			// if not a duplicate
			if (! _namehash[profile.id]){
			
				//add profile
				_namehash[profile.id] = profile;
				_profiles.addItem(profile);
				
				//write data to disk
				dispatch(new SettingsServiceEvent(SettingsServiceEvent.WRITE_REQUEST,"profiles",this));
				dispatch(new ProfilesEvent(ProfilesEvent.ADDED, profile));

			}
			// already exists
			else{
				updateProfile(profile);
			}
		}
		private function verify(profile:ProfileModel):Boolean{
			return true;
		}
		public function deleteProfile(pobj:ProfileModel):void{
			if (pobj == currentprofile){
				currentprofile = null;
			}
			//remove profile
			delete _namehash[pobj.id];
			var index:int = _profiles.getItemIndex(pobj);
			_profiles.removeItemAt(index);
			_profiles.refresh();
			dispatch(new ProfilesEvent(ProfilesEvent.REMOVED,null, pobj.name));
			pobj = null;
			
			//write data to disk
			dispatch(new SettingsServiceEvent(SettingsServiceEvent.WRITE_REQUEST,"profiles",this));
		}
		public function clearAll():void{
			_profiles.removeAll();
			_namehash = null;
			dispatch(new SettingsServiceEvent(SettingsServiceEvent.WRITE_REQUEST,"profiles",this));
			dispatch(new ProfilesEvent(ProfilesEvent.CLEARED));

			//remove from disk
		}
		public function updateProfile(profile:ProfileModel):void{
			// grab the obj reference and change the attributes
			var pobj:ProfileModel = findProfile(profile.id);
			// perform a deep copy
			pobj.copy(profile);
			// write data to disk
			dispatch(new SettingsServiceEvent(SettingsServiceEvent.WRITE_REQUEST,"profiles",this));
			dispatch(new ProfilesEvent(ProfilesEvent.UPDATED, pobj));

		}
		public function findProfile(id:String):ProfileModel{
			return _namehash[id];
		}
		public function copy(p:ProfilesModel):void{
			_namehash = p.namehash;
			_profiles = p.profiles;
			_profiles.refresh();
			this.currentprofile = p.currentprofile;
		}
	
	
	}


	
}