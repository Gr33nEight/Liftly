//
//  PostEntry.swift
//  Liftly
//
//  Created by Natanael Jop on 13/04/2026.
//


struct PostEntry {
    var id: String
    var ownerId: String
    var title: String
    var dateCreated: Date
    var description: String?
    var image: URL?
    var isPublic: Bool
    var likedUsersIds: [String]
    var commentsIds: [String]
    var workout: WorkoutEntry
}