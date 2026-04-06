//
//  PostEndpoint.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation

enum PostEndpoint: FirestoreEndpoint {
    typealias DTO = PostDTO
    static let path: String = "posts"
}
