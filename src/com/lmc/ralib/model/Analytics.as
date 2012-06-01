package com.lmc.ralib.model
{
	
	import com.google.analytics.AnalyticsTracker;
	import com.google.analytics.GATracker;
	import com.google.analytics.core.EventTracker;
	import com.google.analytics.core.TrackerMode;
	
	import flash.display.DisplayObject;
	
	import mx.core.FlexGlobals;
	
	import org.robotlegs.mvcs.Actor;

	public class Analytics extends Actor
	{
		private var tracker:AnalyticsTracker;
		private var evtTracker:EventTracker;

		public function Analytics()
		{
			super();
			tracker = new GATracker(FlexGlobals.topLevelApplication as DisplayObject,"UA-23744720-1","AS3",false);

			// store in cache
			//evtTracker = tracker.createEventTracker("Mobile Device Capabilities");
			//tracker.trackEvent("Startup Time Breakdown", "Startup Time (ms)", null,getTimer()); 
		}
		public function trackEvent():void{
			//tracker.trackEvent("Startup Time Breakdown", "Startup Time (ms)", null,getTimer()); 

		}
		public function trackpageview(name:String):void{
			tracker.trackPageview(name);
		}
		public function trackevent(name:String):void{
			
		}
	}
}