//
//  ExerciseSetMapper.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation

extension ExerciseMapper {
    enum ExerciseSetMapper {
        static func toDTO(_ domain: ExerciseSet) -> ExerciseSetDTO {
            return ExerciseSetDTO(
                type: mapTypeToRaw(domain),
                previous: domain.previous,
                value: domain.value,
                personalRecord: domain.personalRecord
            )
        }
        
        static func toDomain(_ dto: ExerciseSetDTO) -> ExerciseSet {
            return ExerciseSet(
                type: mapTypeToDomain(dto),
                previous: dto.previous,
                value: dto.value,
                personalRecord: dto.personalRecord
            )
        }
        
        private static func mapTypeToRaw(_ domain: ExerciseSet) -> Int {
            switch domain.type {
            case .warmUp: return 0
            case .normal: return 1
            case .failure: return 2
            case .drop: return 3
            }
        }
        
        private static func extractNumber(_ type: SetType) -> Int? {
            switch type {
            case .normal(let num): return num
            default: return nil
            }
        }
        
        private static func mapTypeToDomain(_ dto: ExerciseSetDTO) -> SetType {
            switch dto.type {
            case 0:
                return .warmUp
            case 1:
                return .normal(dto.number ?? 1)
            case 2:
                return .failure
            case 3:
                return .drop
            default:
                return .normal(0)
            }
        }
    }
}
