//
//  AuthClientImpl.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

@preconcurrency import FirebaseAuth

final class AuthClientImpl: AuthClient {
    let auth: Auth
    
    init(auth: Auth = .auth()) {
        self.auth = auth
    }
    
    func signIn(email: String, password: String) async throws -> AuthSession {
        let result = try await auth.signIn(withEmail: email, password: password)
        return AuthSession(uid: result.user.uid)
    }
    
    func signUp(email: String, password: String) async throws -> AuthSession {
        let result = try await auth.createUser(withEmail: email, password: password)
        return AuthSession(uid: result.user.uid)
    }
    
    func signOut() throws {
        try auth.signOut()
    }
    
    func listenToAuthState() -> AsyncStream<AuthSession?> {
        AsyncStream { continuation in
            let handle = auth.addStateDidChangeListener { _, user in
                if let user {
                    continuation.yield(
                        AuthSession(uid: user.uid)
                    )
                } else {
                    continuation.yield(nil)
                }
            }
            let auth = self.auth
            continuation.onTermination = { @Sendable _ in
                Task { @MainActor in
                    auth.removeStateDidChangeListener(handle)
                }
            }
        }
    }
    
}
