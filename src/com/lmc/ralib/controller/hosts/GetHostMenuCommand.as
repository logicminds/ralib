package com.lmc.ralib.controller.hosts
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.menus.Menus;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetHostMenuCommand extends Command
	{
		[Inject] public var menu:Menus;
		
		public function GetHostMenuCommand()
		{
			super();
		}
		
		override public function execute():void{
			dispatch(new MenuEvent(MenuEvent.RESULT_HOST_MENU, menu.hostmenu));
		}
	}
}