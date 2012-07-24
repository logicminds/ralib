package com.lmc.ralib.controller
{
	import com.lmc.ralib.Events.DialogPopUpEvent;
	import com.lmc.ralib.components.InputDialog;
	import com.lmc.ralib.components.InputUserDialog;
	import com.lmc.ralib.utils.LogicMindsUtils;
	import com.pialabs.eskimo.controls.SkinnableInputDialog;
	import com.pialabs.eskimo.controls.SkinnablePasswordInputDialog;
	
	import flash.display.Sprite;
	import flash.events.Event;
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
			if(NativeTextInputDialog.isSupported && LogicMindsUtils.isMobile()){
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
				var dialog:SkinnablePasswordInputDialog = SkinnablePasswordInputDialog.show(event.message, event.title, 
					SkinnablePasswordInputDialog.CANCEL|SkinnablePasswordInputDialog.OK,
					contextView as Sprite,onUserPassTextInputDialogClosedHandler);
				dialog.username = event.username;
				dialog.password = event.password;
			
			}

		}
		private function openInputdialog():void{
			if(NativeTextInputDialog.isSupported && LogicMindsUtils.isMobile()){
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
				var dialog:SkinnableInputDialog = SkinnableInputDialog.show(event.message, event.title, 
					SkinnableInputDialog.CANCEL|SkinnableInputDialog.OK,
					contextView as Sprite,onTextInputDialogClosedHandler);
			}

		}
		
		private function onTextInputDialogClosedHandler(event:*):void
		{
			var fields:Object = new Object();
			
			if (event is NativeDialogEvent){
				for each (var n:NativeTextField in textInputDialog.textInputs)
				{
					fields[n.name] = n.text;
				}
			}
			else{
				fields["input"] = event.currentTarget.inputvalue;
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
		private function onUserPassTextInputDialogClosedHandler(event:*):void
		{
			var fields:Object = new Object();

			if (event is NativeDialogEvent){
				for each (var n:NativeTextField in textInputDialog.textInputs)
				{
					fields[n.name] = n.text;
				}
			}
			else{
				fields["username"] = event.currentTarget.username;
				fields["password"] = event.currentTarget.password;
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