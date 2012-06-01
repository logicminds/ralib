package com.lmc.ralib.services
{

	import biz.logicminds.restclientlib.RestClient;
	import biz.logicminds.restclientlib.RestEvent;
	
	import com.lmc.ralib.model.*;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.utils.Dictionary;
	
	import mx.rpc.AsyncToken;
	import mx.utils.Base64Encoder;
	import mx.utils.URLUtil;
	
	import org.robotlegs.mvcs.Actor;
	import com.lmc.ralib.Events.RestClientEvent;
	
	public class ForemanClient extends RemoteServiceBase
	{
		
		private var eventtype:String;
		private var restclient:RestClient;
		private var serializedClass:Class;
		private var tokenhash:Dictionary = new Dictionary();
		
		public function ForemanClient()
		{
			super();
			restclient = new RestClient();
			restclient.addEventListener(RestEvent.IOERROR, processIOError);
		}
		
		public override function type():String{
			return "Foreman";
		}
		public override function version():String{
			return "0.4.0";
			
		}
		public override function setupClient(host:String, port:String, creds:String, secure:Boolean):void{
			// sets up the restclient
			if (creds && creds.length > 0){
				restclient.credentials = creds;
			}
			restclient.host = host;
			restclient.port = port
			restclient.secure = secure;
		}
		public override function getBookmarks():void{
			showBusy(true);
			var serial:Object = this.createSerialObject(RestClientEvent.BOOKMARKS, com.lmc.ralib.model.Bookmarks);
			restclient.setupRequest(RestClient.METHOD_GET, "bookmarks");
			restclient.addparam("format","json");
			var token:AsyncToken = restclient.sendrequest();
			token.addEventListener(RestEvent.RESULT, onResult);
			tokenhash[token] = serial;

		}
		public override function getclasses():void{
			showBusy(true);
			var serial:Object = this.createSerialObject(RestClientEvent.PUPPETCLASSES, com.lmc.ralib.model.PuppetClasses);
			restclient.setupRequest(RestClient.METHOD_GET, "puppetclasses");
			restclient.addparam("format","json");
			var token:AsyncToken = restclient.sendrequest();
			token.addEventListener(RestEvent.RESULT, onResult);
			tokenhash[token] = serial;
		}
		
		public override function gethosts(query:String=null, etype:String=null):void{
			showBusy(true);
			if (!etype && !query){
				etype = RestClientEvent.HOSTS;
			}
			var serial:Object = this.createSerialObject(etype, com.lmc.ralib.model.Hosts);
			restclient.setupRequest(RestClient.METHOD_GET, "hosts");
			if (query){
				restclient.addparam("search", query);
			}
			restclient.addparam("format","json");
			var token:AsyncToken = restclient.sendrequest();
			token.addEventListener(RestEvent.RESULT, onResult);
			tokenhash[token] = serial;
			
		}
		
		public override function gethostinfo(hostfqdn:String, hostresource:String=null):void{
			showBusy(true);
			var serial:Object = this.createSerialObject(RestClientEvent.HOST, com.lmc.ralib.model.Host);
			if (hostresource){
				restclient.setupRequest(RestClient.METHOD_GET, "hosts/" + hostfqdn + "/" + hostresource);
			}
			else{
				restclient.setupRequest(RestClient.METHOD_GET, "hosts");
				restclient.resourceid = hostfqdn;
			}
			restclient.addparam("format","json");
			var token:AsyncToken = restclient.sendrequest();
			token.addEventListener(RestEvent.RESULT, onResult);
			tokenhash[token] = serial;
		}
		public override function gethostclasses(host:String):void{
			showBusy(true);
			var serial:Object = this.createSerialObject(RestClientEvent.HOST_CLASSES, com.lmc.ralib.model.PuppetClasses);
            restclient.setupRequest(RestClient.METHOD_GET, "hosts/" + host + "/puppetclasses");
			restclient.addparam("format","json");
			var token:AsyncToken = restclient.sendrequest();
			token.addEventListener(RestEvent.RESULT, onResult);
			tokenhash[token] = serial;
		}
		public override function gethostgroups():void{
			showBusy(true);
			var serial:Object = this.createSerialObject(RestClientEvent.HOSTGROUPS, com.lmc.ralib.model.HostGroups);
			restclient.setupRequest(RestClient.METHOD_GET, "hostgroups");
			restclient.addparam("format","json");
			var token:AsyncToken = restclient.sendrequest();
			token.addEventListener(RestEvent.RESULT, onResult);
			tokenhash[token] = serial;
		}
		public override function gethostgroup(id:String):void{
			showBusy(true);
			var serial:Object = this.createSerialObject(RestClientEvent.HOSTGROUP, com.lmc.ralib.model.HostGroup);
			restclient.setupRequest(RestClient.METHOD_GET, "hostgroups");
			restclient.resourceid = id;
			restclient.addparam("format","json");
			var token:AsyncToken = restclient.sendrequest();
			token.addEventListener(RestEvent.RESULT, onResult);
			tokenhash[token] = serial;
		}
		public override function updateHostGroup(data:Object):void{
			showBusy(true);
			eventtype = RestClientEvent.UPDATE_HOSTGROUP;
			serializedClass = com.lmc.ralib.model.HostGroup;
			restclient.setupRequest(RestClient.METHOD_PUT, "hostgroups");
			restclient.resourceid = data.hostgroup.id;
			restclient.addparam("format","json");
			restclient.addEventListener(RestEvent.RESULT, onWriteResult);
			restclient.sendrequest(data);
		}
		public override function updateMultipleHostGroup(data:Object):void{
			showBusy(true);
			var serial:Object = this.createSerialObject(RestClientEvent.MULTIPLE_HOSTS, com.lmc.ralib.model.Host);
			restclient.setupRequest(RestClient.METHOD_POST, "hosts/update_multiple_hostgroup");
			//restclient.resourceid = data.id;
			//restclient.addparam("format","json");
			var token:AsyncToken = restclient.sendrequest(data);
			token.addEventListener(RestEvent.RESULT, onWriteResult);
			tokenhash[token] = serial;
		}
		public override function getstatus():void{
			showBusy(true);
			var serial:Object = this.createSerialObject(RestClientEvent.STATUS, Object);
			// this will check verify the server is ok
			//http://0.0.0.0:3000/home/status?format=json
			restclient.setupRequest(RestClient.METHOD_GET, "status");
			restclient.addparam("format","json");
			var token:AsyncToken = restclient.sendrequest();
			token.addEventListener(RestEvent.RESULT, onResult);
			tokenhash[token] = serial;
			
		}
		public override function getdashboard():void{
			showBusy(true);
			var serial:Object = this.createSerialObject(RestClientEvent.DASHBOARD, com.lmc.ralib.model.DashModel);
			restclient.setupRequest(RestClient.METHOD_GET, "dashboard");
			restclient.addparam("format","json");
			var token:AsyncToken = restclient.sendrequest();
			token.addEventListener(RestEvent.RESULT, onResult);
			tokenhash[token] = serial;
			
		}
		public override function search(resource:String, query:String):void{
			showBusy(true);
			// this will use the foreman search query
			// you must pass in the query string and this will format it and send to the server
			//example http://foreman:80/hosts?search="hostgroup=testgroup"&format=json
			// this will set the type and format for the foreman api
			
			restclient.setupRequest(RestClient.METHOD_GET, resource);
			restclient.addparam("search", query);
			restclient.addparam("format","json");
			restclient.addEventListener(RestEvent.RESULT, onResult);
			restclient.sendrequest();
			
			
		}
		public override function getreports(page:int=1, reportid:int=-1, query:String=null, numreports:int=10):void{
			var serial:Object;
			serial = this.createSerialObject(RestClientEvent.REPORTS, com.lmc.ralib.model.Reports);
			showBusy(true);
			restclient.setupRequest(RestClient.METHOD_GET, "reports");
		
			if (query){
				restclient.addparam("search", query);
			}
			if (reportid < 0){
				restclient.addparam("page", page.toString());
				restclient.addparam("numreports", numreports.toString());
				restclient.addparam("format","json");
			}
			else{
				serial.eventtype = RestClientEvent.REPORT;
				restclient.resourceid = reportid.toString();
				restclient.addparam("format","json");
			}
			var token:AsyncToken = restclient.sendrequest();
			token.addEventListener(RestEvent.RESULT, onResult);
			tokenhash[token] = serial;
		}
		public override function getfactvalues(query:String):void{
			showBusy(true);
			var serial:Object = this.createSerialObject(RestClientEvent.FACTVALUES, com.lmc.ralib.model.FactValues);
			restclient.setupRequest(RestClient.METHOD_GET, "fact_values");
			restclient.addparam("search", "fact+%3D+" + query);
			restclient.addparam("format","json");
			var token:AsyncToken = restclient.sendrequest();
			token.addEventListener(RestEvent.RESULT, onResult);
			tokenhash[token] = serial;
			
		}
		public override function getfacts():void{
			showBusy(true);
			var serial:Object = this.createSerialObject(RestClientEvent.FACTS, com.lmc.ralib.model.Facts);
			restclient.setupRequest(RestClient.METHOD_GET, "facts");
			restclient.addparam("format","json");
			var token:AsyncToken = restclient.sendrequest();
			token.addEventListener(RestEvent.RESULT, onResult);
			tokenhash[token] = serial;
		}
		public override function gethostfacts(fqdn:String):void{
			showBusy(true);
			var serial:Object = this.createSerialObject(RestClientEvent.HOSTFACTS, com.lmc.ralib.model.HostFacts);
			restclient.setupRequest(RestClient.METHOD_GET, "hosts/" + fqdn + "/facts");
			restclient.addparam("format","json");
			var token:AsyncToken = restclient.sendrequest();
			token.addEventListener(RestEvent.RESULT, onResult);
			tokenhash[token] = serial;
			
		}
		public override function getproxylist():void{
			showBusy(true);
			var serial:Object = this.createSerialObject(RestClientEvent.PROXYLIST, Array);
			restclient.setupRequest(RestClient.METHOD_GET, "smart_proxies");
			restclient.addparam("format","json");
			var token:AsyncToken = restclient.sendrequest();
			token.addEventListener(RestEvent.RESULT, onResult);
			tokenhash[token] = serial;
		}
		public override function updateHost(data:Object, hostname:String):void{
			showBusy(true);
			serializedClass = Host;
			eventtype = RestClientEvent.UPDATE_HOST;
			restclient.setupRequest(RestClient.METHOD_PUT, "hosts/"+ hostname);
			restclient.addparam("format","json");
			restclient.addEventListener(RestEvent.RESULT, onWriteResult);
			restclient.sendrequest(data);
			
		}
		public override function getproxyinfo(id:int=0, type:String="puppetca"):void{
			showBusy(true);
			eventtype = RestClientEvent.PROXYINFO;
			// need to figure out what I need to get here
			
		/*	restclient.setupRequest(RestClient.METHOD_GET, "smart_proxies");
			restclient.addparam("format","json");
			if (id > 0){
				restclient.resourceid = id.toString();
			}
			else{
				this.hdestination = "/" + resource + "/" + id + "/" + type;
			}
			restclient.addEventListener(RestEvent.RESULT, onResult);
			restclient.sendrequest();
		
			*/
		}
		public override function createGroup(data:Object):void{
			showBusy(true);
			var serial:Object = this.createSerialObject(RestClientEvent.CREATE_GROUP_RESULT, HostGroup);
			restclient.setupRequest(RestClient.METHOD_POST, "hostgroups");
			restclient.addparam("format","json");
			var token:AsyncToken = restclient.sendrequest(data);
			token.addEventListener(RestEvent.RESULT, onWriteResult);
			tokenhash[token] = serial;


		}
		private function onResult(event:RestEvent):void{
			var etype:String;
			var sclass:Class;
			if (event.token){
				event.token.removeEventListener(RestEvent.RESULT, onResult);
				etype = tokenhash[event.token].eventtype;
				sclass = tokenhash[event.token].serializedClass;
				delete tokenhash[event.token];

			}
			else{
				// non httpservice event
				restclient.removeEventListener(RestEvent.RESULT, onResult);
				etype = this.eventtype;
				sclass = this.serializedClass;
			}
			var data:* = ForemanDecoder.decode(event.data, sclass);
			switch(event.description){
				case RestClient.SUCCESS:
					this.dispatch(new RestClientEvent(etype, true,data, event.statuscode, event.message));
					break;
				default:
					this.dispatch(new RestClientEvent(etype, false,data, event.statuscode, event.message));
					
					if (event.description == RestClient.ACCESS_DENIED){
						this.dispatch(new RestClientEvent(RestClientEvent.ACCESS_DENIED, false,null, event.statuscode, event.message));
					}
					else{
						this.dispatch(new RestClientEvent(RestClientEvent.FAILED_RESULT, false,null, event.statuscode, event.message));
					}
					break;
				/*
				case RestClient.ACCESS_DENIED:
					this.dispatch(new RestClientEvent(RestClientEvent.ACCESS_DENIED, false,null, event.statuscode, event.message));
					break;
				case RestClient.FAILURE:
					this.dispatch(new RestClientEvent(RestClientEvent.FAILED_RESULT, null, event.statuscode, event.message));
					break;
				*/
			}
			this.showBusy(false);

		}
		private function processIOError(event:RestEvent):void{
			this.dispatch(new RestClientEvent(RestClientEvent.FAILED_RESULT, false,null,-1, event.data));
		}
		private function onWriteResult(event:RestEvent):void{
			var etype:String;
			var sclass:Class;
			if (event.token){
				event.token.removeEventListener(RestEvent.RESULT, onWriteResult);
				etype = tokenhash[event.token].eventtype;
				sclass = tokenhash[event.token].serializedClass;
				delete tokenhash[event.token];
				
			}
			else{
				// non httpservice event
				restclient.removeEventListener(RestEvent.RESULT, onWriteResult);
				etype = this.eventtype;
				sclass = this.serializedClass;
			}
			//TODO have the client send failure results
			
			switch(event.description){
				case RestClient.SUCCESS:
					this.dispatch(new RestClientEvent(etype,true,null, event.statuscode, event.message));
					break;
				default:
					this.dispatch(new RestClientEvent(etype, false,null, event.statuscode, event.message));
					if (event.description == RestClient.ACCESS_DENIED){
						this.dispatch(new RestClientEvent(RestClientEvent.ACCESS_DENIED, false,null, event.statuscode, event.message));
						
					}
					else{
						this.dispatch(new RestClientEvent(RestClientEvent.FAILED_RESULT, false,null, event.statuscode, event.message));
					}
					break;
			}
			this.showBusy(false);			
		}

		
			
		
	}
}