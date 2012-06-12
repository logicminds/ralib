package com.lmc.ralib.controller.Application
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.Events.HelpEvent;
	import com.lmc.ralib.utils.LogicMindsUtils;
	
	import mx.events.CloseEvent;
	
	import org.robotlegs.mvcs.Command;
	
	import spark.events.PopUpEvent;
	
	public class OpenHelpCommand extends Command
	{
		[Inject] public var event:HelpEvent;
		
		public function OpenHelpCommand()
		{
			super();
		}
		public override function execute():void{
			this.commandMap.detain(this);
			eventDispatcher.addEventListener(PopUpEvent.CLOSE, onOpenIssue);
			dispatch(new AlertEvent(AlertEvent.OPEN,event.title, event.message + "\nClick OK to view the tip"));
			// thought about opening a stageweb view, but its too slow un unsightly
			//dispatch(new StageWebViewEvent(StageWebViewEvent.OPEN, "http://bit.ly/JgR66p", "Troubleshooting"));
		}
		private function onOpenIssue(cevent:CloseEvent):void{
			this.eventDispatcher.removeEventListener(PopUpEvent.CLOSE, onOpenIssue);
			if (this.event.link){
				LogicMindsUtils.sendurl(this.event.link);
			}
			this.commandMap.release(this);
		}
	}
}