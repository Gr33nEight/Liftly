//
//  WorkoutRepositoryImpl.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//

import Foundation

final class WorkoutRepositoryImpl: WorkoutRepository {
    private let firestoreClient: FirestoreClient
    
    init(firestoreClient: FirestoreClient) {
        self.firestoreClient = firestoreClient
    }
    
    func createWorkout(_ workout: Workout) async throws {
        let dto = WorkoutMapper.toDTO(workout)
        try await firestoreClient.setData(dto, for: WorkoutEndpoint.self, id: .init(value: workout.id), merge: false)
    }
    
    func deleteWorkout(by id: String) async throws {
        try await firestoreClient.delete(for: WorkoutEndpoint.self, id: .init(value: id))
    }
    
    func updateWorkout(_ workout: Workout) async throws {
        let dto = WorkoutMapper.toDTO(workout)
        try await firestoreClient.setData(dto, for: WorkoutEndpoint.self, id: .init(value: workout.id), merge: true)
    }
    
    func fetchWorkouts(by ownersIds: [String]) async throws -> [Workout] {
        let query = FirestoreQuery().isIn(.field("ownersIds"), ownersIds.map({ .string($0) }))
        let results = try await firestoreClient.fetch(WorkoutEndpoint.self, query: query)
        return try results.map({ try WorkoutMapper.toDomain($0) })
    }
    
    func fetchWorkout(by id: String) async throws -> Workout {
        let result = try await firestoreClient.fetchDocument(WorkoutEndpoint.self, id: .init(value: id))
        return try WorkoutMapper.toDomain(result)
    }
}
