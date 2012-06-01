package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.Events.AlertEvent;
	import com.lmc.ralib.components.HostsList;
	import com.lmc.ralib.components.ViewMediatorBase;
	import com.lmc.ralib.model.*;
	
	import flash.events.MouseEvent;
	
	import mx.events.CloseEvent;
	
	import org.robotlegs.mvcs.Mediator;

	public class HostsViewMediator extends ViewMediatorBase
	{
		public function HostsViewMediator()
		{
			super();
		}
		
		[Inject] public var view:HostsView;
		
		override public function onRegister():void{
		//	this.eventMap.mapListener(view.addbutt,MouseEvent.CLICK, onMouseClick);
		//	this.addContextListener(SystemModelEvent.SYSTEM_ADDED, onAdded);
		//	this.addContextListener(CloseEvent.CLOSE, onAlertClose);
			
		}
		private function onAlertClose(event:CloseEvent):void{
			trace("alert closed");
		}
	
		private function onMouseClick(event:MouseEvent):void{
			//var sys:String = view.systemtext.text;
			//dispatch(new SystemModelEvent(SystemModelEvent.ADD_REQUEST, sys));
		
		}
		private function onAdded(event:SystemModelEvent):void{
			//view.systemtext.text = "";
			//dispatch(new AlertEvent(AlertEvent.OPEN,"Alert", event.system + " was added"));
			
		}
	}
}