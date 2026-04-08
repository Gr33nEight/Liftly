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
                number: extractNumber(domain.type),
                type: mapTypeToRaw(domain.type),
                value: ExerciseValueMapper.toDTO(domain.value)
            )
        }

        static func toDomain(_ dto: ExerciseSetDTO) -> ExerciseSet {
            return ExerciseSet(
                type: mapTypeToDomain(dto),
                value: ExerciseValueMapper.toDomain(dto.value)
            )
        }

        // MARK: - TYPE

        private static func mapTypeToRaw(_ type: SetType) -> Int {
            switch type {
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
                return .normal(1)
            }
        }
    }
}
