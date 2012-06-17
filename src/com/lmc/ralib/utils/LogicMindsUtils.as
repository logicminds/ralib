package com.lmc.ralib.utils
{
	import com.adobe.utils.DateUtil;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Capabilities;
	
	import mx.core.FlexGlobals;

	public class LogicMindsUtils extends Object
	{
		public function LogicMindsUtils()
		{
			super();
		}
		public static function totimeago(time:String):String{
			var utilsobj:LogicMindsUtils = new LogicMindsUtils();
			
			return utilsobj.timeago(time);
		}
		/*
		
		
		private function findcap():void{
			var diagonal:Number;
			//Capabilities.screenDPI
			if (Capabilities.cpuArchitecture == "ARM"){
				trace("This is a mobile device");
				var dpi:int = Capabilities.screenDPI;
				var screenX:int = Capabilities.screenResolutionX;
				var screenY:int = Capabilities.screenResolutionY;
				diagonal = Math.sqrt((screenX*screenY)+(screenY*screenX))/dpi;
				
				if (diagonal < 5) {
					trace("This is a mobile phone");
				}
				else{
					trace("Screen size is " + diagonal.toString());
				}
				
			}
		}
		*/
		public static function sendurl(urlcmd:String):void{
			var request:URLRequest = new URLRequest(urlcmd); 
			try { 
				navigateToURL(request); 
			} 
			catch (e:Error) { 
				trace("Error occurred!");
			}
		}
		public function timeago(time:String):String{
			var then_date:Number = DateUtil.parseW3CDTF(time).getTime();
			var now_date:Number = new Date().getTime();
			
			var delta_minutes:Number = Math.floor((now_date - then_date) / 60000);
			
			delta_minutes = delta_minutes;
			if (Math.abs(delta_minutes) <= 523440){
				var distance:String = time_in_words(delta_minutes);
				if (delta_minutes < 0){
					return distance + " ago";
				}
				else{
					return distance + " ago";
				}
			}
			return "";
		}
		public static function sendemail(subject:String, body:String, values:String):void
		{

			//var subject:String = "RemoteAdmin Fact Report: " + this.data.fact.name;
			//var body:String = "The Fact name " + this.data.fact.name + " has the following values associated with it.\n";
			//var values:String = "\n"; 
			body += values;
			var urlcmd:String = 'mailto:?subject=' + subject + '&body=' + body;
			var request:URLRequest = new URLRequest(urlcmd);
			try { 
				
				flash.net.navigateToURL(request); 
			} 
			catch (e:Error) { 
				trace("Error occurred!");
			}

		}
		
		public function time_in_words(minutes:Number):String{
			
			if (minutes < 1){
				return "less than a minute";
			}
			else if (minutes < 50){
				if (minutes == 1){
					return "1 minute";
				}
				else{
					return minutes + " minutes";
				}
			}
			else if (minutes < 90){
				return "about one hour";
			}
			else if (minutes < 1080){
				return Math.round(minutes / 60) + " hours";
			}	
			else if (minutes < 1440){
				return "one day";
			}
			else if (minutes < 2880){
				return "about one day";
			}
			else if (minutes > 2880){
				return (Math.round(minutes / 1440)) + " days";
			}
			
			return "";
		}
		public static function isAndroid():Boolean
		{
			return (Capabilities.version.substr(0,3) == "AND");
		}
		public static function isIOS():Boolean
		{
			return (Capabilities.version.substr(0,3) == "IOS");
		}
		public static function isMobile():Boolean
		{
			return (isAndroid() || isIOS()); // || isBlackberry()
		}
		//based on http://coockbooks.adobe.com/post_Copying_a_datagrid_data_to_the_clipboard_for_Excel-9883.html
		protected static var tabDelimiter:String = "\t";
		protected static var commaDelimiter:String = ","; 
		protected static var newLine:String = "\n";						
		/*
		public static function exportDGToClipboard (grid:DataGrid, csv:Boolean = true, onlySelected:Boolean = true):void
		{
			System.setClipboard(exportDGToCSV (grid, csv, onlySelected));
		}
		
		public static function exportADGToClipboard (grid:AdvancedDataGrid, csv:Boolean = true, onlySelected:Boolean = true):void
		{
			System.setClipboard(exportADGToCSV (grid, csv, onlySelected));
		}
		
		public static function exportDGToCSV (grid:DataGrid, csv:Boolean = true, onlySelected:Boolean = true):String
		{
			return exportGridToCSV (grid, csv, onlySelected,true);
		}				
		
		public static function exportADGToCSV (grid:AdvancedDataGrid, csv:Boolean = true, onlySelected:Boolean = true):String
		{
			return exportGridToCSV (grid, csv, onlySelected,true);
		}
		
		protected static function exportGridToCSV (grid:Object, csv:Boolean, onlySelected:Boolean, tofile:Boolean=false):String
		{
			var dataSource:ICollectionView = (onlySelected ? grid.itemsSelected : grid.dataProvider) as ICollectionView;
			
			var headers:String = "";		
			var delimiter:String = ""
			
			if (csv)	
				delimiter = commaDelimiter;
			else
				delimiter = tabDelimiter;
			
			//build header
			for each (var hcol:Object in grid.columns)//coltypes differe between DG & ADG
			{
				if (!hcol.headerText || hcol.headerText == "checkbox"){
					continue;
				}
				if (headers.length > 0)//avoid firstcolumn having extra delimeter
					headers += delimiter;					
				
				headers += hcol.headerText;			
			}
			headers += newLine;
			
			//populate data
			var cursor:IViewCursor = dataSource.createCursor();
			var data:String = "";
			var item:Object;
			var itemData:String;
			
			do 
			{
				item = cursor.current;
				itemData = "";
				
				for each (var col:DataGridColumn in grid.columns)
				{
					if (!col.headerText || col.headerText == "checkbox"){
						continue;
					}
					if (itemData.length > 0)	//avoid firstcolumn having extra delimeter				
						itemData += delimiter;
					
					itemData += col.itemToLabel(item);					
				}
				
				data += itemData +newLine;
			}while (cursor.moveNext())
			
			if (tofile){
				//Created At:,04/17/2012 13:14:52
				//Seasons:,SU 2012
				//Product Lines:,ACG
				//Statuses:,"Drop, Active"
				var date:Date = new Date();
				var searchterms:String;
				var dateformatter:DateTimeFormatter = new DateTimeFormatter("en-US","short", "none");
				dateformatter.setDateTimePattern("MM-dd-yyyy");
				searchterms = "Created At: " + dateformatter.format(date) + " "  + date.hours.toString() +":"+ date.minutes.toString() + ":" + date.seconds.toString() + "\n";
				searchterms += getsearchfilters();
				dateformatter.setDateTimePattern("yyyy-MM-dd");
				var datestring:String = dateformatter.format(date) + "_"  + date.hours.toString() + date.minutes.toString() + 
					date.seconds.toString();
				var filename:String = 	"StudiotrakCSV_" + datestring + ".csv";
				var file:FileReference = new FileReference();
				file.save(searchterms + headers + data,filename);
			}
			return headers + data;
		} 	*/
	}
}