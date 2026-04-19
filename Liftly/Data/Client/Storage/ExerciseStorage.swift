//
//  ExerciseStorage.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//
import SwiftUI

final actor ExerciseStorage {
    private var cache: [Exercise] = []
    
    func load() -> [Exercise] {
        if !cache.isEmpty { return cache }
        
        guard let url = Bundle.main.url(forResource: "exercises", withExtension: "json") else {
            print("❌ File not found")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Exercise].self, from: data)
            
            cache = decoded
            return decoded
            
        } catch {
            print("❌ ERROR:", error)
            return []
        }
    }
}
