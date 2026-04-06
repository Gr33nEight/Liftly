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
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func execute(email: String, password: String) async throws {
        guard !email.isEmpty else {
            throw AuthError.invalidEmail
        }
        
        guard !password.isEmpty else {
            throw AuthError.invalidPassword
        }
        
        try await authRepository.signUp(email: email, password: password)
    }
}
