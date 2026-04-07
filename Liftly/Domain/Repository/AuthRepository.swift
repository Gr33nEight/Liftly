//
//  AuthRepository.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import Foundation

protocol AuthRepository {
    func signIn(email: String, password: String) async throws
    func signUp(email: String, password: String) async throws -> AuthSession
    func signOut() throws
    func listenSession() -> AsyncStream<UserSession>
}
