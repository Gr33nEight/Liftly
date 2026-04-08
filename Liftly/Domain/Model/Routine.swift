//
//  Routine.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//
import SwiftUI

struct Routine: Identifiable {
    let id: UUID = UUID()
    let title: String
    let exercises: [Exercise]
    
    var exerciseTitles: [String] {
        exercises.map(\.title)
    }
}
