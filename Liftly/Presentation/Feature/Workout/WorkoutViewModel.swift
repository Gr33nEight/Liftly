//
//  WorkoutViewModel.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//

import SwiftUI
import Combine

@MainActor
final class WorkoutViewModel: ObservableObject {
    @Published var exercises: [Exercise] = []
    
    private let getExercises: GetExercisesUseCase
    
    init(getExercises: GetExercisesUseCase) {
        self.getExercises = getExercises
    }
    
    func onAppear() async {
        self.exercises = await getExercises.execute()
    }
}
