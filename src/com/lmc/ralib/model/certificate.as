package com.lmc.ralib.model
{
	public class certificate extends Object
	{
		
		/* {"name":"cobbler.logicminds.corp","expires_at":"2016-03-06T21:18:59-08:00",
		"smart_proxy_id":1,"valid_from":"2011-03-08T21:18:59-08:00",
		"fingerprint":"01:4E:57:7D:35:C8:88:29:43:0E:C7:5A:CD:2F:2B:6A",
		"state":"valid"} */
		
		public var name:String = "";
		public var expires:String = "";
		public var id:int = 0;
		public var valid_from:String = "";
		public var fingerprint:String = "";
		public var state:String = "";
		public function certificate(cert:Object=null)
		{
			super();
			if (cert){
				copy(cert);
			}
		}
		public function copy(certobj:Object):void{
			this.name = certobj.name;
			this.expires = certobj.expires_at;
			this.id = certobj.smart_proxy_id;
			this.valid_from = certobj.valid_from;
			this.fingerprint = certobj.fingerprint;
			this.state = certobj.state;
			
		}
		public function isvalid():Boolean{
			if (this.state != "valid"){
				return false;
			}
			return true;
		}
	}
}