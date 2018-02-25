//
//  LineViewController.swift
//  HeatConductionEquation
//
//  Created by Ирина Филиппова on 25.09.17.
//  Copyright © 2017 Ирина Филиппова. All rights reserved.
//

import Cocoa
import DampingModule

class LineViewController: ViewController, NChartSeriesDataSource, NChartValueAxisDataSource {

    /// MARK: PROPERTIES
    
    @IBOutlet var line: NChartView!
    
    func updateData(_ view: NChartView) {
       
        line = view
        
        // Switch on antialiasing.
        line.chart.shouldAntialias = true
        
        // Create series that will be displayed on the chart.
        createSeries()
        
        // Update data in the chart.
        line.chart.updateData()

    }
    
    func createSeries() {
        let series = NChartLineSeries()
        series.dataSource = self
        series.tag = 0
        series.brush = NChartSolidColorBrush(color: NSColor(hue: 1, saturation: 0.3, brightness: 1, alpha: 1))
        series.lineThickness = 3
        line.chart.addSeries(series)
        
        line.chart.cartesianSystem.xAxis.hasOffset = false
        line.chart.cartesianSystem.yAxis.hasOffset = false
        
        line.chart.cartesianSystem.xAxis.dataSource = self
        line.chart.cartesianSystem.yAxis.dataSource = self
    }
    
    func seriesDataSourcePoints(for series: NChartSeries!) -> [Any]! {
        // Create points with some data for the series.
        var result: [NChartPoint] = []
        
        for n in 0...Shared.instance.N - 1 {
            result.append(NChartPoint(state: NChartPointState(x: Double(n) * Shared.instance.tau, y: Shared.instance.w[n], z: 0), for: series))
        }
        
//        result.append(NChartPoint(state: NChartPointState(x: Double(N-1) * super.tau!, y: 0, z: 0), for: series))
        
        return result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        line.chart.licenseKey = "CL287yFxzDCHlM1LSfvg29TNm7YGQ6sDF2Pftfkz3FxKxnxxbDomWDybFFESGnV3cyXS+iqguUSx9vuExpgJpe13ZcIni1+A9ygM4rqNkvbNYlPEGHOYVwGmAHbDsLqmg1Sak4vv8Gao1Rq42tzlsi7W/ujMaJw8TNbbJrtXAU04LZvXRN1MHGAhD2qHq1SQ0YnDg0cC1Sl6WNKrLyiELneSdS1ibnUUy3ZKym7NpBKHz8vV+Zp44ZfKI9rWco7MLLcfokY3pDbXRyC/5szcjAMVAIH2ZrIxuAORivQ/jvrkM1V6d25yJfLIHxnrDok3qU1qLPXbfBoJ3RZU3veJ4KKOaW1lZwkMauWdli7mFb8nIGG+Eft75iI1M0xDFvIznjghXTQHF/+xRrqXO3HiSSDNF23qoc/aCMp1Cm7Tz7nqITLv+AAMdNvTF5jStkEQzVNlLuYqj0HdCmpCKMrVw+Hsps4tyxczFojmW+ocANxNLA+8yT5Ut2E5hQal72sQ9Hg7q3wrnxrACU6wsKnbpVBX1ylQZ3NGUaLOtVY/gImX4OF8wlVf1+PSzuNgF50oMu+P51kIjxTLlLPCz/2/4aPHpYDJRdxUUrQgVoOQWanPXZxSgmuamdZ0FpOSLbYHUfDSxR0Y5QuQ4k6VrQ8Q3w64B3il0EILkqB5476z2dk="
        
        updateData(line)
    }
    
    func seriesDataSourceName(for series: NChartSeries!) -> String! {
        return ""
    }
    
    func valueAxisDataSourceName(for axis: NChartValueAxis!) -> String! {
//        axis.color = NSColor.blue
//        axis.font = NSFont(name: "Arial", size: 20)
//        axis.textColor = NSColor.blue
        
        switch (axis.kind) {
        case .X:
            return "t"
        case .Y:
            return "w(t)"
        default:
            return ""
        }
    }
}

