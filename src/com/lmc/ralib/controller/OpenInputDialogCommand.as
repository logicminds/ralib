package com.lmc.ralib.controller
{
	import com.lmc.ralib.Events.DialogPopUpEvent;
	import com.lmc.ralib.components.InputDialog;
	import com.lmc.ralib.components.InputUserDialog;
	
	import flash.text.SoftKeyboardType;
	
	import mx.managers.PopUpManager;
	
	import org.robotlegs.mvcs.Command;
	
	import pl.mateuszmackowiak.nativeANE.NativeDialogEvent;
	import pl.mateuszmackowiak.nativeANE.dialogs.*;
	
	import spark.events.PopUpEvent;

	
	public class OpenInputDialogCommand extends Command
	{
		[Inject] public var event:DialogPopUpEvent;
		private var textInputDialog:NativeTextInputDialog;
		public function OpenInputDialogCommand()
		{
			super();
		}
		public override function execute():void{
			switch(event.type){
				case DialogPopUpEvent.OPEN_USERPASS:
					openUserPassdialog();
					break;
				case DialogPopUpEvent.OPEN:
					openInputdialog();
					break;
			}
			
		}
		private function openUserPassdialog():void{
			if(NativeTextInputDialog.isSupported){
				this.commandMap.detain(this);

				textInputDialog = new NativeTextInputDialog();
				textInputDialog.theme = NativeTextInputDialog.ANDROID_DEVICE_DEFAULT_DARK_THEME;
				//textInputDialog.addEventListener(NativeDialogEvent.CANCELED,dispatch);
				//textInputDialog.addEventListener(NativeDialogEvent.OPENED,dispatch);
				textInputDialog.addEventListener(NativeDialogEvent.CLOSED, onUserPassTextInputDialogClosedHandler);
				var v:Vector.<NativeTextField> = new Vector.<NativeTextField>();
				var buttons:Vector.<String> = new Vector.<String>();
				buttons.push("Cancel","OK");
			
				var ti:NativeTextField = new NativeTextField("username");
				ti.prompText = "Username";
				ti.text = event.username;
				v.push(ti);
				
				var ti2:NativeTextField = new NativeTextField("password");
				ti2.displayAsPassword = true;
				ti2.prompText = "Password";
				ti2.text = event.password;
				v.push(ti2);
				textInputDialog.setTitle(event.title);
				textInputDialog.show(v, buttons);

			}
			else{
				var dialog:InputUserDialog = new InputUserDialog();
				// create the SkinnablePopUpContainer
				mediatorMap.createMediator(dialog);
				// set the styles
				dialog.username = event.username;
				dialog.password = event.password;
				
				dialog.open(this.contextView, true);
				PopUpManager.centerPopUp(dialog);
			}

		}
		private function openInputdialog():void{
			if(NativeTextInputDialog.isSupported){
				this.commandMap.detain(this);

				textInputDialog = new NativeTextInputDialog();
				textInputDialog.theme = NativeTextInputDialog.ANDROID_DEVICE_DEFAULT_DARK_THEME;
				//textInputDialog.addEventListener(NativeDialogEvent.CANCELED,trace);
				//textInputDialog.addEventListener(NativeDialogEvent.OPENED,trace);
				textInputDialog.addEventListener(NativeDialogEvent.CLOSED, onTextInputDialogClosedHandler);
				var buttons:Vector.<String> = new Vector.<String>();
				buttons.push("Cancel","OK");
				var v:Vector.<NativeTextField> = new Vector.<NativeTextField>();
				var ti:NativeTextField = new NativeTextField("name");
				ti.prompText = "groupname";
				//ti.text = "John Doe";
				v.push(ti);
				textInputDialog.setTitle(event.title);
				textInputDialog.show(v,buttons);
				//textInputDialog.show(event.title,v, buttons);

			}
			else{
				var inputdialog:InputDialog = new InputDialog();
				// create the SkinnablePopUpContainer
				mediatorMap.createMediator(inputdialog);
				// set the styles
				inputdialog.title = event.title;
				inputdialog.open(this.contextView, true);
				PopUpManager.centerPopUp(inputdialog);
			}

		}
		
		private function onTextInputDialogClosedHandler(event:NativeDialogEvent):void
		{
			var fields:Object = new Object();
			for each (var n:NativeTextField in textInputDialog.textInputs)
			{
				fields[n.name] = n.text;
			}
			if (textInputDialog ){
					//textInputDialog.removeEventListener(NativeDialogEvent.CANCELED,trace);
					//textInputDialog.removeEventListener(NativeDialogEvent.OPENED,trace);
					textInputDialog.removeEventListener(NativeDialogEvent.CLOSED, onTextInputDialogClosedHandler);
			}
			dispatch(new PopUpEvent(PopUpEvent.CLOSE,false,false,true,fields));
			//dispatch(new DialogPopUpEvent(DialogPopUpEvent.CLOSE, fields));
			this.commandMap.release(this);
				
		}
		private function onUserPassTextInputDialogClosedHandler(event:NativeDialogEvent):void
		{
			var fields:Object = new Object();
			textInputDialog.textInputs
			for each (var n:NativeTextField in textInputDialog.textInputs)
			{
				fields[n.name] = n.text;
			}
			
			if (textInputDialog ){
				//textInputDialog.removeEventListener(NativeDialogEvent.CANCELED,dispatch);
				//textInputDialog.removeEventListener(NativeDialogEvent.OPENED,dispatch);
				textInputDialog.removeEventListener(NativeDialogEvent.CLOSED, onUserPassTextInputDialogClosedHandler);
			}
			dispatch(new PopUpEvent(PopUpEvent.CLOSE,false,false,true,fields));
			//dispatch(new DialogPopUpEvent(DialogPopUpEvent.CLOSE, fields));
			this.commandMap.release(this);
			
		}

		
	}
}