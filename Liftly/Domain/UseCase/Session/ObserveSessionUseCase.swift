//
//  ObserveSessionUseCase.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import Foundation

protocol ObserveSessionUseCase {
    func stream() -> AsyncStream<UserSession>
}

final class ObserveSessionUseCaseImpl: ObserveSessionUseCase {
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func stream() -> AsyncStream<UserSession> {
        authRepository.listenSession()
    }
}
