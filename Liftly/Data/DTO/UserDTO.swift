//
//  UserDTO.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import Foundation
import FirebaseFirestore

struct UserDTO: Codable, Sendable {
    @DocumentID var id: String?
    var name: String
    var email: String
}
