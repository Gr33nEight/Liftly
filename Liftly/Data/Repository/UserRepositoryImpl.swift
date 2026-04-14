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
    
    func fetchUsers(by userIds: [String]) async throws -> [User] {
        let query = FirestoreQuery().isIn(.documentId, userIds.map({.string($0)}))
        let dtos = try await firestoreClient.fetch(UserEndpoint.self, query: query)
        return try dtos.map({ try UserMapper.toDomain($0) })
    }
    
    func fetchUser(by userId: String) async throws -> User {
        let dto = try await firestoreClient.fetchDocument(UserEndpoint.self, id: .init(value: userId))
        return try UserMapper.toDomain(dto)
    }
}

enum UserError: Error {
    case userNotFound
}
