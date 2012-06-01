package com.lmc.ralib.services
{
	
	public class ForemanDecoder extends Object
	{
		public function ForemanDecoder()
		{
			super();
			
		}
		public static function decode(jsondata:*, classtype:Class, isJson:Boolean=true):*{
			if (jsondata && isJson){
				return new classtype(JSON.parse(jsondata));
			}
			else{
				return new classtype(jsondata);

			}
			return null;
		}
	
	}
}