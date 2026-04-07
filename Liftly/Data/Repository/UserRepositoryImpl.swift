//
//  UserRepository.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import Foundation

final class UserRepositoryImpl: UserRepository {
    private let firestoreClient: FirestoreClient
    
    init(firestoreClient: FirestoreClient) {
        self.firestoreClient = firestoreClient
    }
    
    func createUser(user: User) async throws {
        let userDto = UserMapper.toDTO(user)
        guard let uid = userDto.id else { throw UserError.userNotFound }
        try await firestoreClient.setData(userDto, for: UserEndpoint.self, id: .init(value: uid), merge: false)
    }
    
    func deleteUser(userId: String) async throws {
        try await firestoreClient.delete(for: UserEndpoint.self, id: .init(value: userId))
    }
    
    func listenToUser(userId: String) -> AsyncThrowingStream<User, Error> {
        let stream = firestoreClient.listenDocument(UserEndpoint.self, id: .init(value: userId))
        return UserMapper.toStream(stream)
    }
}

enum UserError: Error {
    case userNotFound
}
