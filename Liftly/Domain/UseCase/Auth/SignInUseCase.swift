//
//  SignInUseCase.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation

protocol SignInUseCase {
    func execute(email: String, password: String) async throws
}

final class SignInUseCaseImpl: SignInUseCase {
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func execute(email: String, password: String) async throws {
        try await authRepository.signIn(email: email, password: password)
    }
}
