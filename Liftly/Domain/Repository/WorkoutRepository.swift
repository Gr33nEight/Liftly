//
//  WorkoutRepository.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//

import Foundation

protocol WorkoutRepository: Sendable {
    func createWorkout(_ entry: WorkoutEntry, transaction: Transaction) throws 
    func deleteWorkout(by id: String) async throws
    func updateWorkout(_ workout: Workout) async throws
    func fetchWorkouts(by ownersIds: [String]) async throws -> [Workout]
    func fetchWorkout(by id: String) async throws -> Workout
}
