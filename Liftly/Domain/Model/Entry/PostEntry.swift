//
//  PostDetails.swift
//  Liftly
//
//  Created by Natanael Jop on 13/04/2026.
//

import SwiftUI

struct PostDetails {
    var id: String
    var owner: User
    var title: String
    var dateCreated: Date
    var description: String?
    var image: URL?
    var isPublic: Bool
    var likedUsers: [User]
    var comments: [Comment]
    var workout: WorkoutEntry
}
