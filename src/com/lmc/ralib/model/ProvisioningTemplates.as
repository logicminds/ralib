package com.lmc.ralib.model
{
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;

	public class ProvisioningTemplates extends baseCollection
	{
		
		
		
		public function ProvisioningTemplates(jsonObject:Object=null)
		{
			super(jsonObject);
			
		}
	
		public function get bootloaders():*{
			
			var ac:ArrayCollection = new ArrayCollection();
		
			for each (var obj:Object in this){
				if (! obj.template_kind){
					continue;
				}
				if (obj.template_kind.name.search("PXE") >= 0){
					ac.addItem(obj);
				}
			}
			return ac;

		}
		public function get unattendedscripts():*{
			var ac:ArrayCollection = new ArrayCollection();
			for each (var obj:Object in this){
				if (! obj.template_kind){
					continue;
				}	
				if (obj.template_kind.name == "provision"){
					ac.addItem(obj);
				}
			}
			return ac;

		}
		
		public function get scripts():*{
			var ac:ArrayCollection = new ArrayCollection();
			for each (var obj:Object in this){
				if (! obj.template_kind){
					continue;
					
				}
				if (obj.template_kind.name == "scripts"){
					ac.addItem(obj);
				}
			}
			return ac;
		}
		public function get finishscripts():*{
			var ac:ArrayCollection = new ArrayCollection();
			for each (var obj:Object in this){
				if (! obj.template_kind){
					continue;
					
				}
				if (obj.template_kind.name == "finish"){
					ac.addItem(obj);
				}
			}
			return ac;
		}
		public function get snippets():*{
			var ac:ArrayCollection = new ArrayCollection();
			for each (var obj:Object in this){
				if (obj.snippet == true){
					ac.addItem(obj);
					
				}
			
			}
			return ac;
		}
		
	}
}