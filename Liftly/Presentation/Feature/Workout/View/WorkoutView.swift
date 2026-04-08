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
            Button("Add Post") {
                Task {
                    await viewModel.createPost()
                }
            }
        }.task {
            await viewModel.onAppear()
        }
    }
}

#Preview {
    WorkoutView(viewModel: WorkoutViewModel(getExercisesUseCase: MockGetExercisesUseCase(), createPostUseCase: MockCreatePostUseCase()))
}
