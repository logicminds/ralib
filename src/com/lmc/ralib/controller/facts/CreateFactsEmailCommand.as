package com.lmc.ralib.controller.facts
{
	import com.lmc.ralib.Events.FactViewEvent;
	import com.lmc.ralib.model.FactValues;
	
	import org.robotlegs.mvcs.Command;
	
	import com.lmc.ralib.utils.LogicMindsUtils;
	
	public class CreateFactsEmailCommand extends Command
	{
		[Inject] public var event:FactViewEvent;
		[Inject] public var factvalues:FactValues;
		public function CreateFactsEmailCommand()
		{
			super();
		}
		public override function execute():void{
			switch(event.type){
				case FactViewEvent.CREATE_FACT_EMAIL:
					emailfactvalues();
					break;
				case FactViewEvent.CREATE_HOSTS_FACT_EMAIL:
					emailfacthosts();
					break;
				
			}
			
		}
		private function emailfactvalues():void{
			var hostgroupstxt:String = new String();
			var subject:String = "RemoteAdmin Fact Report: " + event.factname;
			var body:String = "The Fact name " + event.factname + " has the following values associated with it.\n";
			
			for each (var hostgroup:Object in event.filter.hostgroups){
				hostgroupstxt += hostgroup.name + " , ";
			}
			
			if (hostgroupstxt){
				hostgroupstxt = hostgroupstxt.slice(0, hostgroupstxt.length - 2);
				body += "The results are filtered by the following hostgroups: " + hostgroupstxt + "\n";
			} 
			var values:String = "\n"; 
			
			for each (var item:Object in factvalues.values){
				values += item.value + " = " + item.count + " nodes \n";
				for each (var host:Object in item.hosts){
					values += "\t" + host + "\n";
				}
				values += "\n";
			}
			LogicMindsUtils.sendemail(subject, body, values);
		}
		private function emailfacthosts():void{
			var subject:String = "RemoteAdmin Fact Report: " + event.factname;
			var body:String = "The Fact name " + event.factname + " with value " + event.factvalue + 
				"\nhas the following hosts associated with it.\n";
			var values:String = "\n"; 
			
			for each (var item:Object in event.hosts){
				values += "\t" + item + "\n";
				
			} 
//			body += values;
			LogicMindsUtils.sendemail(subject, body, values);

		}
	}
}