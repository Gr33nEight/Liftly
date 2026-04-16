//
//  GetUserUseCase.swift
//  Liftly
//
//  Created by Natanael Jop on 16/04/2026.
//

import SwiftUI

protocol GetUserUseCase {
    func execute(by id: String) async throws -> User
}

final class GetUserUseCaseImpl: GetUserUseCase {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(by id: String) async throws -> User {
        try await userRepository.fetchUser(by: id)
    }
}
