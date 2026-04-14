//
//  Post.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation

struct Post: Identifiable {
    var id: String
    var ownerId: String
    var title: String
    var dateCreated: Date
    var isPublic: Bool
    var description: String?
    var image: URL?
    var likedUsersIds: [String]
    var commentsIds: [String]
    var workoutId: String
}
