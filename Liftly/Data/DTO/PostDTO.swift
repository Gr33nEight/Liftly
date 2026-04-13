//
//  PostDTO.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation
@preconcurrency import FirebaseFirestore

struct PostDTO: Codable, Sendable {
    @DocumentID var id: String?
    var ownerId: String
    var title: String
    var description: String?
    var image: String
    var likedUsersIds: [String]
    var commentsIds: [String]
    var workoutId: String
}
