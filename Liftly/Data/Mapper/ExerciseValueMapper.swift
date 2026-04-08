//
//  ExerciseValueMapper.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//


enum ExerciseValueMapper {
    static func toDTO(_ domain: ExerciseValue) -> ExerciseValueDTO {
        switch domain {

        case .weightReps(let weight, let reps):
            return ExerciseValueDTO(
                type: "weightReps",
                weight: weight,
                reps: reps
            )

        case .bodyweightReps(let reps):
            return ExerciseValueDTO(
                type: "bodyweightReps",
                reps: reps
            )

        case .duration(let seconds):
            return ExerciseValueDTO(
                type: "duration",
                seconds: seconds
            )

        case .durationWeight(let seconds, let weight):
            return ExerciseValueDTO(
                type: "durationWeight",
                weight: weight,
                seconds: seconds
            )

        case .distanceDuration(let distance, let seconds):
            return ExerciseValueDTO(
                type: "distanceDuration",
                seconds: seconds,
                distance: distance
            )

        case .weightDistance(let weight, let distance):
            return ExerciseValueDTO(
                type: "weightDistance",
                weight: weight,
                distance: distance
            )

        case .other(let text):
            return ExerciseValueDTO(
                type: "other",
                text: text
            )
            
        case .weightedBodyweight(weight: let weight, reps: let reps):
            return ExerciseValueDTO(
                type: "weightedBodyweight",
                weight: weight,
                reps: reps
            )
        }
    }

    static func toDomain(_ dto: ExerciseValueDTO) -> ExerciseValue {
        switch dto.type {

        case "weightReps":
            return .weightReps(
                weight: dto.weight ?? 0,
                reps: dto.reps ?? 0
            )

        case "bodyweightReps":
            return .bodyweightReps(
                reps: dto.reps ?? 0
            )

        case "duration":
            return .duration(
                seconds: dto.seconds ?? 0
            )

        case "durationWeight":
            return .durationWeight(
                seconds: dto.seconds ?? 0,
                weight: dto.weight ?? 0
            )

        case "distanceDuration":
            return .distanceDuration(
                distance: dto.distance ?? 0,
                seconds: dto.seconds ?? 0
            )

        case "weightDistance":
            return .weightDistance(
                weight: dto.weight ?? 0,
                distance: dto.distance ?? 0
            )

        case "other":
            return .other(dto.text ?? "")

        default:
            return .other("unknown")
        }
    }
}
