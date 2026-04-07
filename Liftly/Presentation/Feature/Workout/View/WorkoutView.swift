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
            ScrollView {
                ForEach(viewModel.exercises.indices, id: \.self) { index in
                    let exercise = viewModel.exercises[index]
                    VStack {
                        Text("Name: \(exercise.title)")
                        Text("How to: \(exercise.howTo)")
                        Text("Equipment: \(exercise.equipment.displayName)")
                        Text("Primary: \(exercise.primaryMuscleGroup.displayName)")
                        Text("Other: \(exercise.otherMuscleGroup.displayName)")
                        Text("Type: \(exercise.exerciseType.displayName)")
                    }
                }
            }
        }.task {
            await viewModel.onAppear()
        }
    }
}
