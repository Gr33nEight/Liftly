//
//  ExerciseRepository.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//

import Foundation

protocol ExerciseRepository {
    func getAll() async -> [Exercise]
}
