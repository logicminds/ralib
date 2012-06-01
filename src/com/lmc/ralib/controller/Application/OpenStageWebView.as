package com.lmc.ralib.controller.Application
{
	import com.lmc.ralib.Events.StageWebViewEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.LocationChangeEvent;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.system.Capabilities;
	
	import org.robotlegs.mvcs.Command;
	
	public class OpenStageWebView extends Command
	{
		[Inject] public var event:StageWebViewEvent;
		
		private var stageweb:StageWebView;
		public function OpenStageWebView()
		{
			super();
		}
		override public function execute():void{
			var stage:Stage = this.contextView.stage;
			if (event.type == StageWebViewEvent.OPEN){
				if (StageWebView.isSupported){
					this.contextView.stage.width
					//var screenX:int = Capabilities.screenResolutionX;
					//var screenY:int = Capabilities.screenResolutionY;
					stageweb = new StageWebView();
					stageweb.viewPort = new Rectangle(5,20,stage.width-50, stage.height-90);
					stageweb.stage = this.contextView.stage;
					stageweb.loadURL(event.url);
					
					dispatch(new StageWebViewEvent(StageWebViewEvent.DISPLAYED, event.url, event.title, stageweb));
				}
			}
			else if (event.type == StageWebViewEvent.CLOSE){
				if (StageWebView.isSupported){
					stageweb = event.stageweb;
					stageweb.viewPort = null;
					stageweb.dispose();
				}
			}
			
		}
		
	}
}