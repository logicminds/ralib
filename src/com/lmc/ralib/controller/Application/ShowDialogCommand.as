package com.lmc.ralib.controller.Application
{
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.model.AppKeeper;
	import com.lmc.ralib.utils.LogicMindsUtils;
	import com.pialabs.eskimo.controls.SkinnableAlert;
	
	import flash.desktop.NativeApplication;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.system.Capabilities;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	import mx.utils.ObjectUtil;
	
	import org.robotlegs.mvcs.Command;
	
	import pl.mateuszmackowiak.nativeANE.NativeDialogEvent;
	import pl.mateuszmackowiak.nativeANE.alert.NativeAlert;
	
	import spark.events.PopUpEvent;
	
	public class ShowDialogCommand extends Command
	{
		[Inject] public var event:AlertEvent;
		[Inject] public var appkeeper:AppKeeper;
		public function ShowDialogCommand()
		{
			super();
		}
		override public function execute():void{
			if (appkeeper.isAlertOpen(event.message)){
				//prevent multiple alerts of the same type
				return;
			}
			appkeeper.pushAlertType(event.message);
			
			if (NativeAlert.isSupported){
				callNativeAlert();
			}
			else {
					SkinnableAlert.show(event.message, event.title, SkinnableAlert.OK|SkinnableAlert.CANCEL,contextView as Sprite, closeHandler);				
			}
			
		}
		private function closeHandler(cevent:*):void{
			var info:Object = ObjectUtil.getClassInfo(cevent);
			appkeeper.removeAlert(event.message);
			if (info.name == "mx.events::CloseEvent"){
				this.dispatch(cevent);
			}
			else{
				var nevent:CloseEvent = new CloseEvent(CloseEvent.CLOSE);
				dispatch(nevent);
			}
			this.commandMap.release(this);
		}
		protected function callNativeAlert():void
		{
			
			if(Capabilities.os.indexOf('Linux')>-1)
				NativeAlert.show(event.message,event.title,"OK", "Cancel"  , closeHandler,false);
			//if (Capabilities.os.indexOf('iPhone')>-1)
			else 
				NativeAlert.show(event.message,event.title,"OK", "Cancel" , closeHandler);
		
		}
		
	}
}