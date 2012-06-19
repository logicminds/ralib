package com.lmc.ralib.controller.Application
{
	import com.lmc.ralib.Events.ApplicationEvent;
	import com.lmc.ralib.model.Bookmarks;
	import com.lmc.ralib.model.DashModel;
	import com.lmc.ralib.model.Facts;
	import com.lmc.ralib.model.HostGroups;
	import com.lmc.ralib.model.Hosts;
	import com.lmc.ralib.model.Reports;
	
	import flash.desktop.NativeApplication;
	
	import org.robotlegs.mvcs.Command;
	
	public class ClearCacheRequestCommand extends Command
	{
		[Inject] public var hostgroups:HostGroups;
		[Inject] public var hosts:Hosts;
		[Inject] public var reports:Reports;
		[Inject] public var facts:Facts;
		[Inject] public var dash:DashModel;
		[Inject] public var bookmarks:Bookmarks;
			
		public function ClearCacheRequestCommand()
		{
			super();
		}
		public override function execute():void{
			if (hostgroups.values.length > 0){
				hostgroups.removeAll();
			}
			if (hosts.values.length > 0){
				hosts.removeAll();
			}
			if (reports.values.length > 0){
				reports.removeAll();
			}
			if (facts.values.length > 0){
				facts.removeAll();
			}
			dash.removeAll();
			dispatch(new ApplicationEvent(ApplicationEvent.CLEAR_CACHE_RESULT));
		}
	}
}