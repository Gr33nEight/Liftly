//
//  StoragePath.swift
//  Liftly
//
//  Created by Natanael Jop on 14/04/2026.
//

import Foundation

enum StoragePath {
    case postImage(postId: String)
    case userAvatar(userId: String)
    
    var value: String {
        switch self {
        case .postImage(let postId):
            return "posts/\(postId)/image.jpg"
            
        case .userAvatar(let userId):
            return "users/\(userId)/avatar.jpg"
        }
    }
}
