//
// PieChart.swift
// Favourites
//
// Created by Ray on 7/18/23.
// Copyright © 2021 Google LLC.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation
//
import DGCharts
import SwiftUI
//import IVal

//class PieChartValueFormatter: NSObject, ValueFormatter {
//    func stringForValue(_ value: Double,
//                        entry: ChartDataEntry,
//                        dataSetIndex: Int,
//                        viewPortHandler: ViewPortHandler?) -> String {
//        if let pieEntry = entry as? PieChartDataEntry {
//            return pieEntry.label ?? ""
//        }
//        return ""
//    }
//}

class PieChartValueFormatter: DefaultValueFormatter {
    override func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        if let pieEntry = entry as? PieChartDataEntry {
            return pieEntry.label ?? ""
        }
        return ""
    }
}


struct PieChart: UIViewRepresentable {
    
    var entries: [PieChartDataEntry]
    @Binding var category: Wine.Category
    let pieChart = PieChartView()
    func makeUIView(context: Context) -> PieChartView {
        pieChart.delegate = context.coordinator
        return pieChart
    }
    
    func updateUIView(_ uiView: PieChartView, context: Context) {
        let dataSet = PieChartDataSet(entries: entries)
        dataSet.colors = ChartColorTemplates.colorful()
        let pieChartData = PieChartData(dataSet: dataSet)
        uiView.data = pieChartData
        configureChart(uiView)
        formatCenter(uiView)
        formatDescription(uiView.chartDescription)
        formatLegend(uiView.legend)
        formatDataSet(dataSet)
        uiView.notifyDataSetChanged()
    }
    
    class Coordinator: NSObject, ChartViewDelegate {
        var parent: PieChart
        init(parent: PieChart) {
            self.parent = parent
        }
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
//            let labelText = entry.value(forKey: "label")! as! String
//            let num = Int(entry.value(forKey: "value")! as! Double)
//            parent.pieChart.centerText = """
//                \(labelText)
//                \(num)
//                """
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func configureChart( _ pieChart: PieChartView) {
        pieChart.rotationEnabled = true
        pieChart.animate(xAxisDuration: 0.5, easingOption: .easeInOutCirc)
        pieChart.drawEntryLabelsEnabled = false
        pieChart.highlightValue(x: -1, dataSetIndex: 0, callDelegate: false)
        pieChart.extraTopOffset = 30
        pieChart.extraBottomOffset = 30
        pieChart.extraLeftOffset = 30
        pieChart.extraRightOffset = 30
    }
    
    func formatCenter(_ pieChart: PieChartView) {
        pieChart.holeColor = UIColor.systemBackground
//        pieChart.centerText = category.rawValue.capitalized
        pieChart.centerTextRadiusPercent = 0.95
    }
    
    func formatDescription( _ description: Description) {
        description.text = category.rawValue.capitalized
        description.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    func formatLegend(_ legend: Legend) {
        legend.enabled = false
    }
    
    func formatDataSet(_ dataSet: ChartDataSet) {
//        dataSet.drawValuesEnabled = true
        if let dataSet = dataSet as? PieChartDataSet {
                dataSet.drawValuesEnabled = true
                dataSet.xValuePosition = .outsideSlice
                dataSet.yValuePosition = .outsideSlice
                dataSet.valueTextColor = UIColor.black
                dataSet.valueFormatter = PieChartValueFormatter()
            }
    }
}

struct PieChart_Previews : PreviewProvider {
    static var previews: some View {
        PieChart(entries: Wine.entriesForWines(Wine.allWines, category: .variety),
                 category: .constant(.variety))
            .frame(height: 400)
            .padding()
    }
}

