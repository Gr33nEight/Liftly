//
//  ExerciseValueDTO.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//

struct ExerciseValueDTO: Codable {
    var type: String
    
    var weight: Double?
    var reps: Int?
    var seconds: Int?
    var distance: Double?
    var text: String?
}
