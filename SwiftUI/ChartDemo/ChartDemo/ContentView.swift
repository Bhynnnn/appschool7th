//
//  ContentView.swift
//  ChartDemo
//
//  Created by 강보현 on 1/15/25.
//

import SwiftUI
import Charts

struct ContentView: View {
    var body: some View {
        Chart {
            AreaMark(
                x: .value("Month", "Jan"),
                y: .value("Temp", 50)
            )
            AreaMark(
                x: .value("Month", "Feb"),
                y: .value("Temp", 43)
            )
            AreaMark(
                x: .value("Month", "Mar"),
                y: .value("Temp", 61)
            )
        }
    }
}

#Preview {
    ContentView()
}
