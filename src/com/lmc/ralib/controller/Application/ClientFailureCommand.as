package com.lmc.ralib.controller.Application
{
	import com.lmc.ralib.Events.*;
	import com.lmc.ralib.model.RestError;
	import com.lmc.ralib.services.ForemanDecoder;
	import com.lmc.ralib.Events.RestClientEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class ClientFailureCommand extends Command
	{
		[Inject] public var event:RestClientEvent;
		public function ClientFailureCommand()
		{
			super();
		}
		override public function execute():void{
			var error:RestError;
			try{
				 error = ForemanDecoder.decode(event.message, com.lmc.ralib.model.RestError);

			}
			catch(e:*){
				trace("The error has no json code");
				error = new RestError();
				error.message = event.message;
				
			}

			if (event.statuscode < 0){
				dispatch(new AlertEvent(AlertEvent.OPEN,"Client Error", error.message));
					
			}
			else{
				dispatch(new AlertEvent(AlertEvent.OPEN,"Client Failure Alert", 
					error.message + "\nStatus Code: " + event.statuscode.toString()));
			}
			
		}
	}
}