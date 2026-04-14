//
//  ExerciseRepositoryImpl.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//

import Foundation

final class TrackedExerciseRepositoryImpl: TrackedExerciseRepository, @unchecked Sendable {
    private let firestoreClient: FirestoreClient
    
    init(firestoreClient: FirestoreClient) {
        self.firestoreClient = firestoreClient
    }
    
    func fetchExercise(by id: String) async throws -> TrackedExercise {
        let result = try await firestoreClient.fetchDocument(TrackedExerciseEndpoint.self, id: .init(value: id))
        return try ExerciseMapper.toDomain(result)
    }
    
    func fetchExercises(by workoutId: String) async throws -> [TrackedExercise] {
        let query = FirestoreQuery().isEqual(.field("workoutId"), .string(workoutId))
        let results = try await firestoreClient.fetch(TrackedExerciseEndpoint.self, query: query)
        return try results.map({ try ExerciseMapper.toDomain($0) })
    }
    
    func createExercise(_ exercise: TrackedExercise) async throws -> String {
        let dto = ExerciseMapper.toDTO(exercise)
        try await firestoreClient.setData(dto, for: TrackedExerciseEndpoint.self, id: .init(value: exercise.id), merge: false)
        return exercise.id
    }
    
    func createExercises(_ trackedExercises: [TrackedExerciseEntry], transaction: Transaction) throws {
        let dtos = trackedExercises.map({ ExerciseMapper.toDTO($0) })
        for dto in dtos {
            guard let dtoId = dto.id else { continue }
            try transaction.setData(dto, for: TrackedExerciseEndpoint.self, id: .init(value: dtoId))
        }
    }
    
    func updateExercise(_ exercise: TrackedExercise) async throws {
        let dto = ExerciseMapper.toDTO(exercise)
        try await firestoreClient.setData(dto, for: TrackedExerciseEndpoint.self, id: .init(value: exercise.id), merge: true)
    }
    
    func deleteExercise(by id: String) async throws {
        try await firestoreClient.delete(for: TrackedExerciseEndpoint.self, id: .init(value: id))
    }
}
