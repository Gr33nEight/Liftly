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
    
    func createWorkout(_ entry: WorkoutEntry) async throws {
        try await firestoreClient.runTransaction { transaction in
            let exerciseDTOs = entry.exercises.map({ ExerciseMapper.toDTO($0) })
            
            for dto in exerciseDTOs {
                guard let dtoId = dto.id else { continue }
                try transaction.setData(dto, for: ExerciseEndpoint.self, id: .init(value: dtoId))
            }
            
            let workout = Workout(
                id: entry.id,
                duration: entry.duration,
                volume: entry.volume,
                sets: entry.sets,
                exercisesIds: exerciseDTOs.compactMap({ $0.id }))
            let workoutDTO = WorkoutMapper.toDTO(workout)
            
            try transaction.setData(workoutDTO, for: WorkoutEndpoint.self, id: .init(value: entry.id))
        }
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
