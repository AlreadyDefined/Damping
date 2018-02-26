//
//  SurfaceViewController.swift
//  HeatConductionEquation
//
//  Created by Ирина Филиппова on 25.09.17.
//  Copyright © 2017 Ирина Филиппова. All rights reserved.
//

import Cocoa
import DampingModule

class Surface1ViewController: ViewController, NChartSeriesDataSource, NChartValueAxisDataSource {
    
    /// MARK: PROPERTIES
    
    @IBOutlet var surface: NChartView!
    
    func updateData(_ view: NChartView) {
            surface = view
        
            // Switch on antialiasing.
            surface.chart.shouldAntialias = true
        
            // Switch 3D on.
            surface.chart.drawIn3D = true
        
            // Create series that will be displayed on the chart.
            createSeries()
        
            // Update data in the chart.
            surface.chart.updateData()
    }
    
    func createSeries() {
            let series = NChartSurfaceSeries()
            series.dataSource = self
            series.tag = 0
            series.brush = NChartSolidColorBrush(color: NSColor(red: 0.38, green: 0.8, blue: 0.91, alpha: 1.0))
            //let smoother = Smooth()
            //smoother.resolution = 50
            //series.dataSmoother = smoother
            surface.chart.addSeries(series)
        
            surface.chart.cartesianSystem.xAxis.hasOffset = false
            surface.chart.cartesianSystem.yAxis.hasOffset = false
            surface.chart.cartesianSystem.zAxis.hasOffset = false
        
            surface.chart.cartesianSystem.xAxis.dataSource = self
            surface.chart.cartesianSystem.yAxis.dataSource = self
            surface.chart.cartesianSystem.zAxis.dataSource = self
    }
    
    func seriesDataSourcePoints(for series: NChartSeries!) -> [Any]! {
        var result: [NChartPoint] = []
            // Create points with some data for the series.
        
            for k in 1...Shared.instance.K + 1 {
                for m in 0...Shared.instance.M {
                    let state = NChartPointState(x: Double(k) * Shared.instance.h_phi, y: Shared.instance.solution[Shared.instance.N - 1][k][m], z: (Double(m) + 0.5) * Shared.instance.h_r)
                    result.append(NChartPoint(state: state, for: series))
                }
            }
        return result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (Shared.instance.T == 0) {
            Helper.ShowAlert(messageText: "Файл не загружен", alertStyle: .critical, informativeText: "Выберите файл с данными перед построением графика")
            self.dismiss(-1)
        }
        
        surface.chart.licenseKey = "CL287yFxzDCHlM1LSfvg29TNm7YGQ6sDF2Pftfkz3FxKxnxxbDomWDybFFESGnV3cyXS+iqguUSx9vuExpgJpe13ZcIni1+A9ygM4rqNkvbNYlPEGHOYVwGmAHbDsLqmg1Sak4vv8Gao1Rq42tzlsi7W/ujMaJw8TNbbJrtXAU04LZvXRN1MHGAhD2qHq1SQ0YnDg0cC1Sl6WNKrLyiELneSdS1ibnUUy3ZKym7NpBKHz8vV+Zp44ZfKI9rWco7MLLcfokY3pDbXRyC/5szcjAMVAIH2ZrIxuAORivQ/jvrkM1V6d25yJfLIHxnrDok3qU1qLPXbfBoJ3RZU3veJ4KKOaW1lZwkMauWdli7mFb8nIGG+Eft75iI1M0xDFvIznjghXTQHF/+xRrqXO3HiSSDNF23qoc/aCMp1Cm7Tz7nqITLv+AAMdNvTF5jStkEQzVNlLuYqj0HdCmpCKMrVw+Hsps4tyxczFojmW+ocANxNLA+8yT5Ut2E5hQal72sQ9Hg7q3wrnxrACU6wsKnbpVBX1ylQZ3NGUaLOtVY/gImX4OF8wlVf1+PSzuNgF50oMu+P51kIjxTLlLPCz/2/4aPHpYDJRdxUUrQgVoOQWanPXZxSgmuamdZ0FpOSLbYHUfDSxR0Y5QuQ4k6VrQ8Q3w64B3il0EILkqB5476z2dk="
        
            updateData(surface)
    }
    
    func seriesDataSourceName(for series: NChartSeries!) -> String! {
        return ""
    }
    
    func valueAxisDataSourceName(for axis: NChartValueAxis!) -> String! {
        //axis.color = NSColor.blue
        //axis.font = NSFont(name: "Arial", size: 20)
        //axis.textColor = NSColor.blue
            switch (axis.kind) {
            case .X:
                return "phi"
            case .Z:
                return "r"
            case .Y:
                return "u"
            default:
                return ""
            }
    }
}

