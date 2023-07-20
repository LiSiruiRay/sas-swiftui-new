//
// Wine.swift
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
import DGCharts
import Foundation

struct Wine {
    enum Category: String {
        case variety, winery
    }
    var category: Category
    var value:Double
    var label:String
    
    static func entriesForWines(_ wines: [Wine], category: Category) -> [PieChartDataEntry] {
        let requestedWines = wines.filter {$0.category == category}
        return requestedWines.map { PieChartDataEntry(value: $0.value, label: $0.label)}
    }
    static var allWines:[Wine] {
        [
            Wine(category: .variety, value: 6, label: "Chardonnay"),
            Wine(category: .variety, value: 2, label: "Merlot"),
            Wine(category: .variety, value: 5, label: "Pinot Gris"),
            Wine(category: .variety, value: 7, label: "Gewürtztraminer"),
            Wine(category: .variety, value: 12, label: "Red Blend"),
            Wine(category: .variety, value: 10, label: "White Blend"),
            Wine(category: .variety, value: 3, label: "Sauvingnon Blanc"),
            Wine(category: .variety, value: 6, label: "Cabernet Franc"),
            Wine(category: .winery, value: 5, label: "Sumac Ridge"),
            Wine(category: .winery, value: 8, label: "Mission Hill"),
            Wine(category: .winery, value: 5, label: "50th Parallel"),
            Wine(category: .winery, value: 6, label: "Quails Gate"),
            Wine(category: .winery, value: 3, label: "Tumbler Ridge"),
            Wine(category: .winery, value: 12, label: "Moraine"),
            Wine(category: .winery, value: 18, label: "Tantalus")
        ]
    }
}

