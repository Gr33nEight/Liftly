//
//  UserEndpoint.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import Foundation

enum UserEndpoint: FirestoreEndpoint {
    typealias DTO = UserDTO
    static var path: String = "users"
}
