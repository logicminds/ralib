package com.lmc.ralib.components.charts
{
	
	import mx.charts.CategoryAxis;
	import mx.charts.ColumnChart;
	import mx.charts.Legend;
	import mx.charts.effects.SeriesInterpolate;
	import mx.charts.series.ColumnSeries;
	import mx.collections.ArrayCollection;
	import mx.events.PropertyChangeEvent;
	
	import spark.components.Group;
	
	public class TimeChart extends Group
	{
		[Bindable] public var dataProvider:ArrayCollection;
		// Graphs
		private var timechart:ColumnChart = new ColumnChart();
		private var timeseries:ColumnSeries = new ColumnSeries();
		private var legend:Legend = new Legend();
		private var si:SeriesInterpolate = new SeriesInterpolate();
		private var vAxis:CategoryAxis = new CategoryAxis();
		
		public function TimeChart()
		{
			super();
			this.addEventListener("propertyChange", dpChange);
			
		}
		private function dpChange(event:PropertyChangeEvent):void{
			createtimegraph();
		}
		private function createtimegraph():void{
			
			//{changes:metric.changes, events:metric.events.total, resources: metric.resources.total, time: metric.time});
			// first make a graph of the metric time object
			
				// create chart object and set properties
				
				timechart.showDataTips = true;
				timechart.dataProvider = dataProvider;
				timechart.right = 0;
				timechart.left = 0;
				timechart.top = 0;
				timechart.bottom = 0;
				timechart.percentHeight = 100;
				timechart.percentWidth = 100;
				
				
				// Column sizing
				timeseries.columnWidthRatio = 0.85;
				timeseries.maxColumnWidth = 10;
				
				// Define the axis
				vAxis.categoryField = "name";
				
				timechart.horizontalAxis = vAxis;
				
				// Add the series
				
				//timeseries.xField = "name";
				timeseries.yField = "value";
				
				//timeseries.displayName = "Time";
				
				// Effects
				si.duration = 580;
				si.target = timechart;
				
				timechart.series = [timeseries];
				
				// create a legend
				
				legend.dataProvider = timechart;
				
						
			
			// Attach chart to display object
			this.addElement(timechart);
		//	this.addElement(legend);
			
			
		}
	}
}