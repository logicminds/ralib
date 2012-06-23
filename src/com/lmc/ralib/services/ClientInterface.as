package com.lmc.ralib.services
{
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.Events.RestClientEvent;

	public interface ClientInterface
	{
		function type():String;
		function version():String;	
	    function setupClient(host:String, port:String, creds:String, secure:Boolean, timeout:int=30):void; 
		function gethosts(query:String=null, etype:String=null):void;
		function gethostinfo(host:String, hostresource:String=null):void
		function gethostgroups():void;
		function gethostgroup(id:String):void;
		function getstatus():void;
		function getclasses():void;
		function search(resource:String, query:String):void;
		function getreports(page:int=1, reportid:int=-1, query:String=null, numreports:int=10):void;
		function getfactvalues(factname:String):void;
		function getfacts():void;
		function gethostfacts(host:String):void;
		function gethostclasses(host:String):void;
		function getproxylist():void;
		function getproxyinfo(id:int=0, type:String="puppetca"):void;
		function getdashboard():void;
		function updateHost(data:Object, hostname:String):void;
		function createGroup(data:Object):void;
		function updateHostGroup(data:Object):void;
		function updateMultipleHostGroup(data:Object):void;
		function getBookmarks():void;
		
	}
}