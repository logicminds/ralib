package com.lmc.ralib.components.charts
{
	import mx.charts.BarChart;
	import mx.charts.CategoryAxis;
	import mx.charts.Legend;
	import mx.charts.series.BarSeries;
	import mx.collections.ArrayCollection;
	import mx.events.PropertyChangeEvent;
	
	import spark.components.Group;
	import spark.layouts.VerticalLayout;
	
	public class MetricChart extends Group
	{
		[Bindable] public var dataProvider:ArrayCollection;
		private var mchart:BarChart = new BarChart();
		private var mseries:BarSeries = new BarSeries();
		private var mlegend:Legend = new Legend();
		private var vAxis:CategoryAxis = new CategoryAxis();
		public function MetricChart()
		{
			super();
			this.addEventListener("propertyChange", dpChange);
			
		}
		private function dpChange(event:PropertyChangeEvent):void{
			createmetricsgraph();
		}
		private function createmetricsgraph():void{
			
			//{changes:metric.changes, events:metric.events.total, resources: metric.resources.total, time: metric.time});
			// first make a graph of the metric time object
			//this.layout = new VerticalLayout();
				// create chart object and set properties
				mchart = new BarChart();
				mchart.showDataTips = true;
				mchart.dataProvider = dataProvider;
				mchart.right = 0;
				mchart.left = 0;
				mchart.top = 0;
				mchart.bottom = 0;
				mchart.percentHeight = 100;
				mchart.percentWidth = 100;
				
				// Define the axis
				vAxis = new CategoryAxis();
				vAxis.categoryField = "name";
				vAxis.dataProvider = dataProvider;
				mchart.verticalAxis = vAxis;
				
				// Add the series
				mseries = new BarSeries();
				mseries.xField = "value";
				mseries.yField = "name";
				mseries.displayName = "Number";
				
				mchart.series = [mseries];
				
				// create a legend
				mlegend = new Legend();
				mlegend.dataProvider = mchart;
				
				
		
			// Attach chart to display object
			this.addElement(mchart);
		//	this.addElement(mlegend);
			
		}
	}
}