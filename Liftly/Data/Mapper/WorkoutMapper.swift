//
//  WorkoutMapper.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation

enum WorkoutMapper {
    static func toDTO(_ domain: Workout) -> WorkoutDTO {
        return WorkoutDTO(
            id: domain.id,
            duration: domain.duration,
            volume: domain.volume,
            sets: domain.sets,
            exercisesIds: domain.exercisesIds
        )
    }
    
    static func toDomain(_ dto: WorkoutDTO) throws -> Workout {
        guard let id = dto.id else {
            throw MapperError.missingId
        }
        
        return Workout(
            id: id,
            duration: dto.duration,
            volume: dto.volume,
            sets: dto.sets,
            exercisesIds: dto.exercisesIds
        )
    }
    
    static func toStream(_ stream: AsyncThrowingStream<WorkoutDTO, Error>) -> AsyncThrowingStream<Workout, Error> {
        AsyncThrowingStream { continuation in
            let task = Task {
                do {
                    for try await dto in stream {
                        try continuation.yield(WorkoutMapper.toDomain(dto))
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
            
            continuation.onTermination = { _ in
                task.cancel()
            }
        }
    }
    
    static func toDTO(_ entry: WorkoutEntry) -> WorkoutDTO {
        return WorkoutDTO(
            id: entry.id,
            duration: entry.duration,
            volume: entry.volume,
            sets: entry.sets,
            exercisesIds: entry.exercises.compactMap({$0.id}))
    }
    
    static func toEntry(_ domain: Workout, exercises: [TrackedExercise]) -> WorkoutEntry{
        return WorkoutEntry(
            id: domain.id,
            duration: domain.duration,
            volume: domain.volume,
            sets: domain.sets,
            exercises: exercises)
    }
}
