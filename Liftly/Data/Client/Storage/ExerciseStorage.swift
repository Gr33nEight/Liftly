//
//  ExerciseStorage.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//
import SwiftUI

final actor ExerciseStorage {
    
    static let shared = ExerciseStorage()
    
    private var cache: [Exercise] = []
    
    func load() -> [Exercise] {
        if !cache.isEmpty { return cache }
        
        guard let url = Bundle.main.url(forResource: "exercises", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([Exercise].self, from: data)
        else {
            return []
        }
        
        cache = decoded
        return decoded
    }
}
