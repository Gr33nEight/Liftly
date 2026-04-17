//
//  RoutineMapper.swift
//  Liftly
//
//  Created by Natanael Jop on 14/04/2026.
//

import Foundation

enum RoutineMapper{
    static func toDTO(_ domain: Routine) -> RoutineDTO {
        return RoutineDTO(
            id: domain.id,
            title: domain.title,
            exercisesIds: domain.exercisesIds,
            ownerId: domain.ownerId
        )
    }
    
    static func toDomain(_ dto: RoutineDTO) throws -> Routine {
        guard let id = dto.id else {
            throw MapperError.missingId
        }
        
        return Routine(
            id: id,
            title: dto.title,
            exercisesIds: dto.exercisesIds,
            ownerId: dto.ownerId
        )
    }
    
    static func toDomain(_ input: CreateRoutineInput, routineId: String) -> Routine {
        Routine(
            id: routineId,
            title: input.title,
            exercisesIds: input.trackedExercises.map({$0.id}),
            ownerId: input.ownerId
        )
            
    }
    
    static func toEntry(_ domain: Routine, trackedExercises: [TrackedExerciseEntry]) -> RoutineEntry {
        return RoutineEntry(
            id: domain.id,
            title: domain.title,
            trackedExercises: trackedExercises,
            ownerId: domain.ownerId
        )
    }
}
    
