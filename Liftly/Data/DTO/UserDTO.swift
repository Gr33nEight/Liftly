//
//  UserDTO.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import Foundation

struct UserDTO: Codable, Sendable {
    var id: String?
    var name: String
    var email: String
}
