//
//  AuthRepositoryImpl.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import Foundation

final class AuthRepositoryImpl: AuthRepository {
    private let authClient: AuthClient
    
    init(authClient: AuthClient) {
        self.authClient = authClient
    }
    
    func signIn(email: String, password: String) async throws {
        _ = try await authClient.signIn(email: email, password: password)
    }
    
    func signUp(email: String, password: String) async throws -> AuthSession {
        let session = try await authClient.signUp(email: email, password: password)
        return .init(uid: session.uid)
    }
    
    func signOut() throws {
        try authClient.signOut()
    }
    
    func listenSession() -> AsyncStream<UserSession> {
        AsyncStream { continuation in
            let stream = authClient.listenToAuthState()
            Task {
                for await session in stream {
                    guard let session else {
                        continuation.yield(.loggedOut)
                        continue
                    }
                    
                    continuation.yield(.loggedIn(uid: session.uid))
                }
            }
        }
    }
}


