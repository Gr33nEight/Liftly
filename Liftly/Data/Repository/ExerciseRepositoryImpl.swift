//
//  ExerciseRepositoryImpl.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//

import Foundation

final class ExerciseRepositoryImpl: ExerciseRepository {
    private let storage: ExerciseStorage
    
    init(storage: ExerciseStorage) {
        self.storage = storage
    }
    
    func getAll() async -> [Exercise] {
        await storage.load()
    }
}
