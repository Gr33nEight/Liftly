//
//  SignOutUseCase.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import Foundation

protocol SignOutUseCase {
    func execute() throws
}

final class SignOutUseCaseImpl: SignOutUseCase {
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func execute() throws {
        try authRepository.signOut()
    }
}
