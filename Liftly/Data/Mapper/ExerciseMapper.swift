//
//  ExerciseMapper.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation

enum ExerciseMapper {
    static func toDTO(_ domain: TrackedExercise) -> TrackedExerciseDTO {
        return TrackedExerciseDTO(
            id: domain.id,
            workoutId: domain.workoutId,
            exerciseId: domain.exerciseId,
            restTime: domain.restTime,
            sets: mapSetToDTO(domain.sets)
        )
    }
    
    static func toDTO(_ entry: TrackedExerciseEntry) -> TrackedExerciseDTO {
        return TrackedExerciseDTO(
            id: entry.id,
            workoutId: entry.workoutId,
            exerciseId: entry.exercise.id,
            restTime: entry.restTime,
            sets: mapSetToDTO(entry.sets)
        )
    }
    
    static func toDomain(_ dto: TrackedExerciseDTO) throws -> TrackedExercise {
        guard let id = dto.id else {
            throw MapperError.missingId
        }
        
        return TrackedExercise(
            id: id,
            workoutId: dto.workoutId,
            exerciseId: dto.exerciseId,
            restTime: dto.restTime,
            sets: mapSetToDomain(dto.sets)
        )
    }
    
    private static func mapSetToDTO(_ sets: [ExerciseSet]) -> [ExerciseSetDTO] {
        sets.map({ ExerciseSetMapper.toDTO($0) })
    }
    
    private static func mapSetToDomain(_ sets: [ExerciseSetDTO]) -> [ExerciseSet] {
        sets.map({ ExerciseSetMapper.toDomain($0) })
    }
}
