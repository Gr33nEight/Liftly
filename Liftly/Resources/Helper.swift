//
//  Helper.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//

import Foundation
// MARK: - API Model

struct ApiExercise: Decodable {
    let name: String
    let type: String
    let muscle: String
    let difficulty: String
    let instructions: String
    let equipments: [String]?
}

// MARK: - Service

final class ExerciseService: Sendable {

    private let apiKey = "ZfLrXHfBZpbaQFrnhVSS5iz3fWk1FKELNrGhsQbp"

    private let muscles = [
        "abdominals","abductors","adductors","biceps","calves","chest",
        "forearms","glutes","hamstrings","lats","lower_back","middle_back",
        "neck","quadriceps","traps","triceps"
    ]

    func fetchAllExercises() async throws -> [Exercise] {
        var result: [Exercise] = []

        // 🔥 równoległe requesty (dużo szybciej)
        try await withThrowingTaskGroup(of: [Exercise].self) { group in

            for muscle in muscles {
                group.addTask {
                    try await self.fetchExercises(for: muscle)
                }
            }

            for try await exercises in group {
                result.append(contentsOf: exercises)
            }
        }

        return result
    }

    private func fetchExercises(for muscle: String) async throws -> [Exercise] {
        let urlString = "https://api.api-ninjas.com/v1/exercises?muscle=\(muscle)"
        guard let url = URL(string: urlString) else { return [] }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoded = try JSONDecoder().decode([ApiExercise].self, from: data)

        return decoded.map(mapToExercise)
    }

    // MARK: - Mapping

    private func mapToExercise(_ api: ApiExercise) -> Exercise {
        return Exercise(
            title: api.name,
            image: nil,
            howTo: api.instructions,
            equipment: mapEquipment(api.equipments),
            primaryMuscleGroup: mapMuscle(api.muscle),
            otherMuscleGroup: .other,
            exerciseType: mapType(api.type)
        )
    }

    private func mapEquipment(_ values: [String]?) -> Equipment {
        guard let first = values?.first?.lowercased() else { return .none }

        switch first {
        case "barbell": return .barbell
        case "dumbbells", "dumbbell": return .dumbell
        case "kettlebell": return .kettlebell
        case "machine": return .machine
        case "plate": return .plate
        case "bands": return .resistanceBand
        default: return .other
        }
    }

    private func mapMuscle(_ value: String) -> MuscleGroup {
        switch value {
        case "lower_back": return .lowerBack
        case "middle_back": return .upperBack
        default:
            return MuscleGroup.allCases.first {
                "\($0)" == value
            } ?? .other
        }
    }

    private func mapType(_ value: String) -> ExerciseType {
        switch value {
        case "strength": return .weightReps
        case "cardio": return .duration
        case "plyometrics": return .bodyweightReps
        case "powerlifting": return .weightReps
        case "stretching": return .other
        default: return .other
        }
    }
}


final actor ExerciseStorage: Sendable {

    static let shared = ExerciseStorage()

    private var cache: [Exercise] = []

    private var url: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("exercises.json")
    }

    // 🔥 load once (ultra ważne)
    func load() -> [Exercise] {
        if !cache.isEmpty { return cache }

        guard let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([Exercise].self, from: data)
        else {
            return []
        }

        cache = decoded
        return decoded
    }

    func save(_ exercises: [Exercise]) {
        cache = exercises

        if let data = try? JSONEncoder().encode(exercises) {
            try? data.write(to: url)
        }
    }
}
