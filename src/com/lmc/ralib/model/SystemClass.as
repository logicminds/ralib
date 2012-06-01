package com.lmc.ralib.model 
{
	import mx.collections.ArrayCollection;
	
	public class SystemClass extends Object
	{
		public var parameters:Array;
		public var classes:ArrayCollection = new ArrayCollection();
		public var environment:String;
		public var modules:ArrayCollection = new ArrayCollection();
		
		public function SystemClass(jsonObject:Object)
		{
			// this is what we are working with
		/*	{"helloworld":[{"puppetclass":{"name":"helloworld","id":1}}],"baseapps":[{"puppetclass":{"name":"baseapps","id":4}}]}
			*/
			super();
			
			if (jsonObject){
			
				
				for each (var module:Object in jsonObject)
				{
					
					for each (var classobj:Object in module)
					{
						// we only need one of these objects not both
						classes.addItem({name:classobj.puppetclass.name,id:classobj.puppetclass.id});
						modules.addItem(classobj);
					}
					
				}	
				
			}
		}
		
		
	}
}
