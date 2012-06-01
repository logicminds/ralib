package com.lmc.ralib.model
{
	import mx.collections.ArrayCollection;

	public class HostGroup extends baseModel
	{	
		public var environment:Object;
		public var puppetclasses:PuppetClasses = new PuppetClasses();
		
		public var group_parameters:Array;
		public var ancestry:String;
		public var domain_id:int;
		public var subnet_id:int;
		public var hypervisor_id:int;
		//TODO program the classes for the hostgroup so that it is a sort on the in memory classes to reduce memory footprint

		public function HostGroup(jsonObject:Object=null)
		{
			super("hostgroups", jsonObject);
			
			/*{"hostgroup":{"environment":{"name":"production","id":1},"disk_size":null,
			"interface":null,"subnet_id":null,"name":"dns_server","hypervisor_id":"",
			"classes":[{"puppetclass":{"name":"ssh::auth","lookup_keys":[],"id":41}},
			{"puppetclass":{"name":"memcache","lookup_keys":[],"id":18}},
			{"puppetclass":{"name":"timezone::pacific","lookup_keys":[],"id":51}},
			{"puppetclass":{"name":"vmware","lookup_keys":[],"id":52}},
			{"puppetclass":{"name":"weblogic","lookup_keys":[],"id":55}}],
			"domain_id":1,"memory":null,"storage_pool":null,"parameters":{},"id":2,
			"vcpu":null,"label":"default/dns_server","network_type":null,"operatingsystem_id":null}}
			*/	
		/*	{"hostgroup":{"environment":{"name":"production","id":1},"interface":null,"subnet_id":null,
			"name":"test1","hypervisor_id":null,"vcpu":null,"memory":null,
				"classes":[{"puppetclass":{"name":"helloworld","id":1}}],"storage_pool":null,
			"domain_id":null,"parameters":{},"id":1,"network_type":null,"disk_size":null,"label":"test1"}}
			*/
			if (!jsonObject){
				environment = new Object();
				this.name = "";
				group_parameters = [];
				this.id = -1;
			}
			
		}
		private function toClassArray():Array{
			var ids:Array = [];
			for each (var item:PuppetClass in this.puppetclasses.values){
				ids.push(item.id);
			}
			return ids;
		}
		public function toForemanObject():Object{
			// this will create an object that will spit out forman friendly object ready to be encoded in json
			var obj:Object = new Object();
			var hostgroup:Object = new Object();
			hostgroup.id = this.id;
			hostgroup.name = this.name;
			hostgroup.environment_id = this.environment;
			hostgroup.puppetclass_ids = toClassArray();
			obj.hostgroup = hostgroup;
			return obj;
		}
		public function cloneinto(item:HostGroup):void{
			this.ancestry = item.ancestry;
			this.id = item.id;
			this.name = item.name;
			this.group_parameters = item.group_parameters;
			this.domain_id = item.domain_id;
			this.hypervisor_id = item.hypervisor_id;
			this.subnet_id = item.subnet_id;
			this.properties = item.properties;
			this.puppetclasses = item.puppetclasses;
			this.environment = item.environment;
		}
		public override function copy(jsonObject:Object):void{
			var hostgroup:Object;
				if (jsonObject.hasOwnProperty("hostgroup")){
					hostgroup = jsonObject.hostgroup;
				}
				else{
					hostgroup = jsonObject;
				}

				if (hostgroup.hasOwnProperty("environment") && hostgroup.environment ){
					this.environment = {name:hostgroup.environment.name, id:hostgroup.environment.id};
				}
				this.ancestry = hostgroup.ancestry;
				this.id = hostgroup.id;
				this.name = hostgroup.name;
				this.group_parameters = hostgroup.group_parameters as Array;
				this.domain_id = hostgroup.domain_id;
				this.hypervisor_id = hostgroup.hypervisor_id;
				this.subnet_id = hostgroup.subnet_id;
				//this.properties = hostgroup;
				
				for each (var p:Object in hostgroup.classes) {
					//{"puppetclass":{"name":"timezone::pacific","id":51,"lookup_keys":[]}}
					puppetclasses.addjsonItem(p.puppetclass);
				}
		}
		
	}
}