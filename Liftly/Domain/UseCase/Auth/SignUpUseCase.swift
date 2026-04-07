//
//  SignUpUseCase.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import Foundation

protocol SignUpUseCase {
    func execute(email: String, password: String) async throws
}

final class SignUpUseCaseImpl: SignUpUseCase {
    private let authRepository: AuthRepository
    private let userRepository: UserRepository
    
    init(authRepository: AuthRepository, userRepository: UserRepository) {
        self.authRepository = authRepository
        self.userRepository = userRepository
    }
    
    func execute(email: String, password: String) async throws {
        guard !email.isEmpty else {
            throw AuthError.invalidEmail
        }
        
        guard !password.isEmpty else {
            throw AuthError.invalidPassword
        }
        
        let session = try await authRepository.signUp(email: email, password: password)
        
        let name = email.split(separator: "@").first.map(String.init) ?? "User"
        
        let user = User(
            id: session.uid,
            name: name,
            email: email
        )
        try await userRepository.createUser(user: user)
    }
}
