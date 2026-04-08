//
//  ExerciseRepository.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//

import Foundation

protocol TrackedExerciseRepository: Sendable {
    func fetchExercise(by id: String) async throws -> TrackedExercise
    func fetchExercises(by workoutId: String) async throws -> [TrackedExercise]
    func createExercise(_ exercise: TrackedExercise) async throws -> String
    func createExercises(_ exercises: [TrackedExercise], transaction: Transaction) throws
    func updateExercise(_ exercise: TrackedExercise) async throws
    func deleteExercise(by id: String) async throws
}
