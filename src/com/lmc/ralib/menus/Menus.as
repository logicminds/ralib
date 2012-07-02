package com.lmc.ralib.menus
{
	import com.lmc.ralib.view.*;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Actor;
	
	public class Menus extends Actor
	{
		[Bindable] private var _hostmenu:ArrayCollection = new ArrayCollection();
		[Bindable] private var _factmenu:ArrayCollection = new ArrayCollection();
		public function Menus()
		{
			super();
			createhostmenu();
			createfactmenu();
			
		}
		public function get hostmenu():ArrayCollection{
			return _hostmenu;
		}
		public function get factmenu():ArrayCollection{
			return _factmenu;
		}
		private function createfactmenu():void{
			_factmenu.addItem("List");
			_factmenu.addItem("Graph");
		}
		private function createhostmenu():void{
		//	hostmenu.addItem({name:"Assign Puppet Modules", view: AssignModuleView});
			_hostmenu.addItem({name: "Host Reports", view: ReportsView});
			_hostmenu.addItem({name: "Host Facts", view: HostFactsView});
			_hostmenu.addItem({name: "Host Properties", view: HostPropertiesView});
			_hostmenu.addItem({name: "Puppet Classes", view: HostClassesView});
			//	systemmenu.addItem("Puppet Kick");  # currently not 100% supported under foreman/smart-proxy
			/*	systemmenu.addItem("Perform Actions");
			systemmenu.addItem("Install Software");
			systemmenu.addItem("System Status"); */
		}
	}
}