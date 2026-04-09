
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
    
    var routines: [Routine] {
        guard !exercises.isEmpty else { return [] }

        let chest = exercises.filter { $0.primaryMuscleGroup == .chest }
        let back = exercises.filter { [.lats, .upperBack].contains($0.primaryMuscleGroup) }
        let shoulders = exercises.filter { $0.primaryMuscleGroup == .shoulders }
        let biceps = exercises.filter { $0.primaryMuscleGroup == .biceps }
        let triceps = exercises.filter { $0.primaryMuscleGroup == .triceps }
        let legs = exercises.filter {
            [.quadriceps, .hamstrings, .glutes, .calves].contains($0.primaryMuscleGroup)
        }
        let core = exercises.filter { $0.primaryMuscleGroup == .abdominals }

        return [

            Routine(
                title: "Upper Body A",
                exercises: [
                    chest.prefix(2),
                    shoulders.prefix(1),
                    triceps.prefix(1),
                    biceps.prefix(1)
                ].flatMap { $0 }
            ),

            Routine(
                title: "Upper Body B",
                exercises: [
                    back.prefix(3),
                    biceps.prefix(2)
                ].flatMap { $0 }
            ),

            Routine(
                title: "Push",
                exercises: [
                    chest.prefix(3),
                    shoulders.prefix(2),
                    triceps.prefix(2)
                ].flatMap { $0 }
            ),

            Routine(
                title: "Pull",
                exercises: [
                    back.prefix(4),
                    biceps.prefix(2)
                ].flatMap { $0 }
            ),

            Routine(
                title: "Leg Day",
                exercises: [
                    legs.prefix(6)
                ].flatMap { $0 }
            ),

            Routine(
                title: "Core",
                exercises: [
                    core.prefix(5)
                ].flatMap { $0 }
            ),

            Routine(
                title: "Full Body",
                exercises: [
                    chest.prefix(1),
                    back.prefix(1),
                    legs.prefix(2),
                    shoulders.prefix(1),
                    core.prefix(1)
                ].flatMap { $0 }
            )
        ]
    }
    
    @Published var exercises: [Exercise] = []
    
    private let getExercisesUseCase: GetExercisesUseCase
    
    init(
        getExercisesUseCase: GetExercisesUseCase
    ) {
        self.getExercisesUseCase = getExercisesUseCase
    }
    
    func onAppear() async {
        await getExercises()
    }
    
    private func getExercises() async {
        self.exercises = await getExercisesUseCase.execute()
    }
}



