//
//  ChartsView.swift
//  Liftly
//
//  Created by Natanael Jop on 16/04/2026.
//

import SwiftUI
import Charts

struct ChartsView: View {
    @Binding var selected: String?
    var body: some View {
        Chart(MockData.stats) { workout in
            BarMark(
                x: .value("Day", workout.occurence),
                y: .value("Duration", workout.data)
            )
            .foregroundStyle(
                selected == workout.occurence ?
                    Color.custom.primary :
                    Color.custom.tertiary
            )
            .cornerRadius(5)
        }.frame(height: 200)
//            .chartYAxis(.hidden)
            .chartYAxis {
                AxisMarks(position: .leading) { value in
                    AxisGridLine()
                        .foregroundStyle(Color.gray.opacity(0.2))
                    AxisValueLabel()
                }
            }
            .chartXAxis {
                AxisMarks(position: .bottom) { value in
                    AxisValueLabel()
                }
            }
            .chartXSelection(value: $selected)
            .animation(.easeInOut, value: selected)
    }
}


