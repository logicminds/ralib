package com.lmc.ralib.controller
{
	import com.lmc.ralib.Events.AnalyticsTrackerEvent;
	import com.lmc.ralib.model.Analytics;
	
	import org.robotlegs.mvcs.Command;

	public class TrackPageViewCommand extends Command
	{
		[Inject] public var tracker:Analytics;
		[Inject] public var event:AnalyticsTrackerEvent;
		
		public function TrackPageViewCommand()
		{
		}
		override public function execute():void{	
			tracker.trackpageview(event.page);
		}
	}
}