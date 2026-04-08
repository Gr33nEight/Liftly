//
//  WorkoutView.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//

import SwiftUI

struct WorkoutView: View {
    @StateObject var viewModel: WorkoutViewModel
    var body: some View {
        VStack {
            Text("Workout View")
            Button("Add Workout") {
                Task {
                    await viewModel.createWorkout()
                }
            }
        }.task {
            await viewModel.onAppear()
        }
    }
}
