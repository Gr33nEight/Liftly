//
//  CreatePostInput.swift
//  Liftly
//
//  Created by Natanael Jop on 16/04/2026.
//

import SwiftUI

struct CreatePostInput {
    var ownerId: String
    var title: String
    var dateCreated: Date
    var description: String?
    var image: Data?
    var isPublic: Bool
    var workout: WorkoutEntry
}
