package com.lmc.ralib.services
{
	import biz.logicminds.restclientlib.RestClient;
	import biz.logicminds.restclientlib.RestEvent;
	
	import com.adobe.utils.DateUtil;
	import com.lmc.ralib.Events.RestClientEvent;
	import com.lmc.ralib.model.*;
	import com.lmc.ralib.model.DashModel;
	import com.lmc.ralib.utils.*;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.utils.Base64Encoder;
	import mx.utils.ObjectUtil;
	
	import org.robotlegs.mvcs.Actor;


	public class TestClient extends RemoteServiceBase
	{
		[Inject] public var hosts:Hosts;
		private var olist:Object = new Object();
		private var restclient:RestClient;
		public function TestClient()
		{
			super();
			
		}
		
		public override function type():String{
			return "Test";
		}
		public override function version():String{
			return numitems.toString();
		}
		public override function gethosts(query:String=null,etype:String=null):void{
			showBusy(true);
			if (!etype && !query){
				etype = RestClientEvent.HOSTS;
			}
			var mydata:Hosts =  new Hosts();
			
			for (var i:int=0; i < numitems; i++){
				var host:Host = new Host();
				host.name = "puppetagent" + i;
				mydata.values.addItem(host);
			}
			this.dispatch(new RestClientEvent(etype, true,mydata, 200, RestClientEvent.SUCCESS_RESULT));
			showBusy(false);

		}
		private function getrandom(low:Number, high:Number):Number{
			// return a random item from the provided array
			
			return Math.floor(Math.random() * (1+high-low)) + low;
		}
		public override function gethostinfo(host:String, hostresource:String=null):void{
			showBusy(true);
			var cobj:Object = createSerialObject(RestClientEvent.HOST,com.lmc.ralib.model.Host);
			cobj.loader = new URLLoaderObj();
			olist[cobj.loader.id] = cobj;
			getfromfile("apisamples/hostinfo.json", cobj);

		}
		
		public override function gethostgroups():void{
			showBusy(true);
			var ac:HostGroups = new HostGroups();
		
			for (var i:int=0; i < 10; i++){
				var hostgroup:HostGroup = new HostGroup();
				hostgroup.name = "Hostgroup" + i.toString();
				hostgroup.id = i;
				ac.values.addItem(hostgroup);
			}
			this.dispatch(new RestClientEvent(RestClientEvent.HOSTGROUPS, true,ac, 200, RestClientEvent.SUCCESS_RESULT));
			showBusy(false);

		}
		/*public override function gethostgroup(id:String):void{
			showBusy(true);
			//eventtype = RestClientEvent.HOSTGROUP;
			
			//serializedClass = com.lmc.ralib.model.HostGroup;
			showBusy(false);

		
		} */
		
		public override function gethostclasses(host:String):void{
			showBusy(true);
			var cobj:Object = createSerialObject(RestClientEvent.HOST_CLASSES,com.lmc.ralib.model.PuppetClasses);
			cobj.loader = new URLLoaderObj();
			olist[cobj.loader.id] = cobj;
			getfromfile("apisamples/hostclasses.json", cobj);

			
		}
		public override function getstatus():void{
			showBusy(true);
			
			var status:Object = {"status":200,"version":this.version(),"db_duration_ms":"81","result":"ok"}
			// this will check verify the server is ok
			//http://0.0.0.0:3000/home/status?format=json

			this.dispatch(new RestClientEvent(RestClientEvent.STATUS,true,status, 200, RestClientEvent.SUCCESS_RESULT));

			showBusy(false);

		}
	
		private function addzero(num:Number):String{
			if ( num < 10){
				return String("0" + num.toString());
			}
			return num.toString();
		}
		private function getrandomtime():String{
			var date:Date = new Date();
			var newdate:String = "";
			newdate = (2012).toString() + "-";
			newdate += addzero(getrandom(0,date.month)) + "-";
			newdate += addzero(getrandom(0,date.date)) + "T";
			newdate += addzero(getrandom(0,date.hours)) + ":";
			newdate += addzero(getrandom(0,date.minutes)) + ":";
			newdate += addzero(getrandom(0,date.seconds)) + "Z";
			
			return newdate;
				
			
		}
		public override function getreports(page:int=1, reportid:int=-1, query:String=null, numreports:int=10):void{
			showBusy(true);
			var ransummary:Array = new Array("Success", "Failed", "Modified");
			
			var reports:Reports = new Reports();
			for (var i:int=0; i < 200; i++){
				var report:ReportModel = new ReportModel();
				report.summary = ransummary[getrandom(0,2)];
				report.host = "puppetagent" + this.getrandom(1, numreports);
				report.status = {failed:0,restarted:0,skipped:0,applied:0,failed_restarts:0};
				
				report.reported_at = getrandomtime();
				//	"2012-01-15T02:53:26Z";
				report.id = 810616;
				
				var time:Object = {service:4.149406,schedule:0.013302,cron:0.003433,config_retrieval:2.09590005874634,
					total:7.87903305874634,"package":0.015221,filebucket:0.000785,file:1.172299,exec:0.428687};
				var metrics:Object = new Object();
				metrics.time = time;
				metrics.events = {events:{total:0},resources:{total:33},changes:{total:0}};
				report.metrics = metrics;
				//report.logs = JSON.parse("'logs':[{'log':{'sources':{'source':'Puppet'},'messages':{'message':'Finished catalog run in 34.88 seconds'}}}");
				reports.values.addItem(report);

			} 
				
			this.dispatch(new RestClientEvent(RestClientEvent.REPORTS, true, reports, 200, RestClientEvent.SUCCESS_RESULT));
			showBusy(false);

				
				
			/*if (query){
				restclient.addparam("search", query);
			}
			if (reportid < 0){
				eventtype = ForemanClientEvent.REPORTS;
				restclient.addparam("page", page.toString());
				restclient.addparam("numreports", numreports.toString());
				restclient.addparam("format","json");
			}
			else{
				eventtype = ForemanClientEvent.REPORT;
				restclient.resourceid = reportid.toString();
				restclient.addparam("format","json");
			}
			
			*/
		}
		public override function getclasses():void{
			showBusy(true);
			var cobj:Object = createSerialObject(RestClientEvent.PUPPETCLASSES,com.lmc.ralib.model.PuppetClasses);
			cobj.loader = new URLLoaderObj();
			olist[cobj.loader.id] = cobj;
			getfromfile("apisamples/puppetclasses.json", cobj);
		}
		public override function getfactvalues(factname:String):void{
			showBusy(true);
			var hostdata:Object = {};
			var value:Object = {};
			var factvalue:String;
			var fact:Object;
			var j:Number;
			switch (factname){
				case "architecture":
					value[1] = "i386";
					value[2] = 'x86_64';
					//{"architecture":"i386"}
					for each (var host:Host in hosts.values){
						factvalue = getrandom(0,1) == 0 ? value[1] : value[2];
						fact = {};
						fact[factname] = factvalue;
						hostdata[host.name] = fact;
					}
					break;
				default:
					var num:Number = getrandom(0,30);
					for (var i:int=0; i <= num; i = i + 1){
						// populate random data
						value[i] = "value" + i;
					}
					for each (var h:Host in hosts.values){
						fact = {};
						j = getrandom(0,num); 
						fact[factname] = value[j];
						hostdata[h.name] = fact;
					}
					break;
			}
			
			
			var data:* = ForemanDecoder.decode(hostdata, com.lmc.ralib.model.FactValues,false);

			this.dispatch(new RestClientEvent(RestClientEvent.FACTVALUES, true,data, 200, null));

			showBusy(false);

		}
		private var urlLoader:URLLoaderObj; 
		public function getfromfile(path:String, cobj:Object):void{
			var urlRequest:URLRequest = new URLRequest(path);
			urlLoader = cobj.loader;
			urlLoader.addEventListener(Event.COMPLETE, urlLoader_complete);
			urlLoader.load(urlRequest);
		}
		private function urlLoader_complete(event:Event):void {
			var etype:String = olist[event.target.id].eventtype;
			var sclass:Class = olist[event.target.id].serializedClass;
			trace("Called: ",sclass);
			event.target.removeEventListener(Event.COMPLETE, urlLoader_complete);
			var data:* = ForemanDecoder.decode(event.target.data, sclass);
			this.dispatch(new RestClientEvent(etype, true,data, 200, null));
			showBusy(false);
			// remote the loader
			delete olist[event.target];
			
		}
		
		public override function getfacts():void{
			showBusy(true);
			var cobj:Object = createSerialObject(RestClientEvent.FACTS,com.lmc.ralib.model.Facts);
			cobj.loader = new URLLoaderObj();
			olist[cobj.loader.id] = cobj;
			getfromfile("apisamples/facts.json", cobj);
			
		}
		public override  function gethostfacts(host:String):void{
			showBusy(true);
			var cobj:Object = createSerialObject(RestClientEvent.HOSTFACTS,com.lmc.ralib.model.HostFacts);
			cobj.loader = new URLLoaderObj;
			olist[cobj.loader.id] = cobj;
			getfromfile("apisamples/hostfacts.json", cobj);

		}/*
		public override function getproxylist():void{
			showBusy(true);
			eventtype = ForemanClientEvent.PROXYLIST;
			restclient.setupRequest(RestClient.METHOD_GET, "smart_proxies");
			restclient.addparam("format","json");
			restclient.addEventListener(RestEvent.RESULT, onResult);
			restclient.sendrequest();
			showBusy(false);

		}
		public override function updateHost():void{
			showBusy(true);
			restclient.setupRequest(RestClient.METHOD_PUT, "hosts");
			restclient.addparam("format","json");
			restclient.addEventListener(RestEvent.RESULT, onResult);
			restclient.sendrequest();
			showBusy(false);

			
		}
		*/
		public override function getdashboard():void{
			showBusy(true);
			
			var dashinfo:DashModel = new DashModel({ok_hosts:numitems * .6,
				active_hosts:numitems *.2,good_hosts:numitems *.7,
				out_of_sync_hosts:numitems *.1,disabled_hosts:numitems *.05,reports_missing:numitems *.05,
				percentage:60,total_hosts:numitems,bad_hosts:numitems *.3});
			
			this.dispatch(new RestClientEvent(RestClientEvent.DASHBOARD, true,dashinfo, 200, RestClientEvent.SUCCESS_RESULT));
			showBusy(false);

		}/*
		public override function getproxyinfo(id:int=0, type:String="puppetca"):void{
			showBusy(true);
			eventtype = RestClientEvent.PROXYINFO;
			showBusy(false);

			// need to figure out what I need to get here
			
			restclient.setupRequest(RestClient.METHOD_GET, "smart_proxies");
			restclient.addparam("format","json");
			if (id > 0){
				restclient.resourceid = id.toString();
			}
			
			
			
			
			else{
				this.hdestination = "/" + resource + "/" + id + "/" + type;
			}
			restclient.addEventListener(RestEvent.RESULT, onResult);
			restclient.sendrequest();
		
			
		}
		
		

		
		
				public function create(type:String, obj:Object):void{
					
					// this will be used to create new items on foreman
					this.conn.method = "POST";
					this.settype(type);
					this.conn.contentType = "application/json";
					var dataString:String = JSON.stringify(obj);
					this.conn.send(dataString);
					
				} 
		
		*/
		public override function createGroup(data:Object):void{
			showBusy(true);
			this.dispatch(new RestClientEvent(RestClientEvent.CREATE_GROUP_RESULT, true,null, 200, RestClientEvent.SUCCESS_RESULT));
			showBusy(false);

			
			
		}
		
		
	}
}