//
//  AuthRepository.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import Foundation

protocol AuthRepository {
    func listenSession() -> AsyncStream<UserSession>
}
