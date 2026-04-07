//
//  ExerciseRepositoryImpl.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//

import Foundation

final class TrackedExerciseRepositoryImpl: TrackedExerciseRepository {
    private let firestoreClient: FirestoreClient
    
    init(firestoreClient: FirestoreClient) {
        self.firestoreClient = firestoreClient
    }
    
    func fetchExercise(by id: String) async throws -> TrackedExercise {
        let result = try await firestoreClient.fetchDocument(ExerciseEndpoint.self, id: .init(value: id))
        return try ExerciseMapper.toDomain(result)
    }
    
    func fetchExercises(by workoutId: String) async throws -> [TrackedExercise] {
        let query = FirestoreQuery().isEqual(.field("workoutId"), .string(workoutId))
        let results = try await firestoreClient.fetch(ExerciseEndpoint.self, query: query)
        return try results.map({ try ExerciseMapper.toDomain($0) })
    }
    
    func createExercise(_ exercise: TrackedExercise) async throws -> String {
        let dto = ExerciseMapper.toDTO(exercise)
        try await firestoreClient.setData(dto, for: ExerciseEndpoint.self, id: .init(value: exercise.id), merge: false)
        return exercise.id
    }
    
    func updateExercise(_ exercise: TrackedExercise) async throws {
        let dto = ExerciseMapper.toDTO(exercise)
        try await firestoreClient.setData(dto, for: ExerciseEndpoint.self, id: .init(value: exercise.id), merge: true)
    }
    
    func deleteExercise(by id: String) async throws {
        try await firestoreClient.delete(for: ExerciseEndpoint.self, id: .init(value: id))
    }
}
