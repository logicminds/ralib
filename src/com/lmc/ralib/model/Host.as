package com.lmc.ralib.model 
{
	
	//import com.lmc.models.HostGroup;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectUtil;
	
	[Bindable]
	public class Host extends baseModel
	{
		public var environment_id:int;
		public var parameters:Array;
		public var _classes:ArrayCollection;
		public var environment:Object;
		public var hostgroup_id:int;
		public var puppet_status:int;
		public var facts:Facts;
		//public var _hostgroupdata:HostGroup;
		
		//TODO program the classes for the host so that it is a sort on the in memory classes to reduce memory footprint
		
	   /* public var subnet_id:int;
		public var serial:String;
		public var puppetproxy_id:int;
		public var managed:Boolean;
		
		public var architecture_id:int;
		public var sp_mac:String;
		public var puppetmaster_name:String;
		public var image_file:String;
		public var sp_name:String;
		public var mac:String;
		public var installed_at:String;
		public var domain_id:int;
		public var use_image:Boolean;
		public var root_pass:String;
		public var owner_id:int;
		public var medium_id:int;
		public var enabled:Boolean;
		public var build:Boolean;
		public var ptable_id:int;
		public var sp_subnet_id:int;
		public var source_file_id:int;
		public var model_id:int;
		public var sp_ip:String;
		public var disk:String;
		public var owner_type:String;
		public var operatingsystem_id:int;
		public var last_compile:String; 
		*/
		/*
		
		{"host":{"subnet_id":null,"serial":null,"puppetproxy_id":null,"name":"cobbler.logicminds.corp","managed":true,"last_report":"2011-06-21T22:44:22Z",
		"comment":"","architecture_id":1,"created_at":"2011-03-14T03:47:34Z","sp_mac":"","puppetmaster_name":"puppet.logicminds.corp","image_file":null,
		"updated_at":"2011-08-11T03:27:26Z","sp_name":"","mac":"00:0c:29:57:b5:f3","installed_at":null,"domain_id":1,"use_image":null,
		"root_pass":"xybxa6JUkz63w","owner_id":1,"medium_id":null,"id":3,"hostgroup_id":8,"enabled":true,"build":false,"ptable_id":null,
		"sp_subnet_id":null,"puppet_status":0,"last_freshcheck":null,"ip":"172.16.220.134","environment_id":1,"source_file_id":null,
		"model_id":1,
		"environment":{"environment":{"name":"production","id":1}},
		"sp_ip":"","disk":null,"owner_type":"User",
		"operatingsystem_id":1,"last_compile":"2011-06-21T15:44:22Z"}}
		*/
		
		
		public function Host(jsonObject:Object=null)
		{
			super("hosts",jsonObject);

		}
		public function get hostproperties():ArrayCollection{
			var ac:ArrayCollection = new ArrayCollection();
			return ac;
		}
		public function toForemanObject():*{
			// this will create an object that will spit out forman friendly object ready to be encoded in json
			var hostobj:Object = new Object();
			hostobj.id = this.id;
			//hostobj.managed = "";
			hostobj.name = this.name;
			//hostobj.puppetmaster = "puppet.logicminds.corp";
			//hostobj.enabled = "1";
			hostobj.hostgroup_id = this.hostgroup_id;
			hostobj.environment_id = this.environment_id;
			return hostobj;
		}
		
		public override function copy(jsonObject:Object):void{
			// this is the data module we need to work with
			var host:Object = jsonObject.host;
			//{"ulimits":[{"puppetclass":{"name":"ulimits","id":56}}]
			if (jsonObject){
				if (host.environment){
					environment = host.environment.environment;
				}
				if (host.environment_id){
					environment_id = host.environment_id;
				}
				puppet_status = host.puppet_status;
				hostgroup_id = host.hostgroup_id;
				name = host.name;
				id = host.id;
				properties = host;
			} 
		}
		public function cloneinto(newhost:Host):void{
			if (newhost){
				if (newhost.environment){
					environment = newhost.environment.environment;
				}
				if (newhost.environment_id){
					environment_id = newhost.environment_id;
				}
				puppet_status = newhost.puppet_status;
				hostgroup_id = newhost.hostgroup_id;
				name = newhost.name;
				id = newhost.id;
				properties = newhost.properties;
			} 
		}
		public function get classes():ArrayCollection{
			return _classes;
		}
		public function set classes(data:ArrayCollection):void{
			_classes = data;
		}
	/*	public function get hostgroupdata():HostGroup{
			return this._hostgroupdata;
		}
		public function set hostgroupdata(data:HostGroup):void{
			_hostgroupdata = data;
		}
	*/	
		
	}
}
