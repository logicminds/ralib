package com.lmc.ralib.view
{
	import com.lmc.ralib.Events.AnalyticsTrackerEvent;
	import com.lmc.ralib.Events.ClientRequestEvent;
	import com.lmc.ralib.components.ViewMediatorBase;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class EditGroupViewMediator extends ViewMediatorBase
	{
		[Inject] public var view:EditGroupView;
		public function EditGroupViewMediator()
		{
			super();
		}
		public override function onRegister():void{
			dispatch(new AnalyticsTrackerEvent(AnalyticsTrackerEvent.TRACKPAGEVEW, "Group/EditGroupView-RL"));
			//update the puppetclasses just in case
			dispatch(new ClientRequestEvent(ClientRequestEvent.PUPPETCLASSES, false));
			dispatch(new ClientRequestEvent(ClientRequestEvent.HOSTS, false));
			dispatch(new ClientRequestEvent(ClientRequestEvent.HOSTGROUP, false, null,view.data.gdata.id));

		}
	}
}