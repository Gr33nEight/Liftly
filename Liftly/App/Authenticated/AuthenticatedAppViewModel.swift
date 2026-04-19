//
//  AuthenticatedAppViewModel.swift
//  Liftly
//
//  Created by Natanael Jop on 15/04/2026.
//

import SwiftUI
import Combine

@MainActor
final class AuthenticatedAppViewModel: ObservableObject {
    @Published var exercises: [Exercise] = []

    private let getExercisesUseCase: GetExercisesUseCase
    
    init(getExercisesUseCase: GetExercisesUseCase) {
        self.getExercisesUseCase = getExercisesUseCase
    }

    func preloadExercises() {
        let useCase = self.getExercisesUseCase
        Task {
            let data = await Task.detached {
                await useCase.execute()
            }.value

            self.exercises = data
        }
    }
}
