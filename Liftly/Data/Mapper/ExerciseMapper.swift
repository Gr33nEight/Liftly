//
//  ExerciseMapper.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation

enum ExerciseMapper {
    static func toDTO(_ domain: TrackedExercise) -> ExerciseDTO {
        return ExerciseDTO(
            id: domain.id,
            workoutId: domain.workoutId,
            title: domain.exercise.title,
            image: mapImage(domain.exercise),
            howTo: domain.exercise.howTo,
            equipment: domain.exercise.equipment.rawValue,
            primaryMuscleGroup: domain.exercise.primaryMuscleGroup.rawValue,
            otherMuscleGroup: domain.exercise.otherMuscleGroup.rawValue,
            exerciseType: domain.exercise.exerciseType.rawValue,
            restTime: domain.restTime,
            sets: mapSetToDTO(domain)
        )
    }
    
    static func toDomain(_ dto: ExerciseDTO) throws -> TrackedExercise {
        guard let id = dto.id else {
            throw MapperError.missingId
        }
        
        return TrackedExercise(
            id: id,
            workoutId: dto.workoutId,
            exercise: mapExercise(dto),
            restTime: dto.restTime,
            sets: mapSetToDomain(dto)
        )
    }
    
    private static func mapImage(_ dto: ExerciseDTO) -> URL? {
        return URL(string: dto.image)
    }
    
    private static func mapImage(_ domain: Exercise) -> String {
        return domain.image?.absoluteString ?? ""
    }
    
    private static func mapSetToDTO(_ domain: TrackedExercise) -> [ExerciseSetDTO] {
        domain.sets.map({ ExerciseSetMapper.toDTO($0) })
    }
    
    private static func mapSetToDomain(_ dto: ExerciseDTO) -> [ExerciseSet] {
        dto.sets.map({ ExerciseSetMapper.toDomain($0) })
    }
    
    private static func mapExercise(_ dto: ExerciseDTO) -> Exercise {
        return Exercise(
            title: dto.title,
            howTo: dto.howTo,
            equipment: Equipment(rawValue: dto.equipment) ?? .none,
            primaryMuscleGroup: MuscleGroup(rawValue: dto.primaryMuscleGroup) ?? .other,
            otherMuscleGroup: MuscleGroup(rawValue: dto.otherMuscleGroup) ?? .other,
            exerciseType: ExerciseType(rawValue: dto.exerciseType) ?? .other
        )
    }
}
