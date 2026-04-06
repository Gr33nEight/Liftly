//
//  AuthClient.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//


import Foundation
import FirebaseAuth

protocol AuthClient {
    func signIn(email: String, password: String) async throws -> AuthSession
    func signUp(email: String, password: String) async throws -> AuthSession
    func signOut() throws
    func listenToAuthState() -> AsyncStream<AuthSession?>
}