//
//  UserRepository.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import Foundation

protocol UserRepository: Sendable {
    func createUser(user: User) async throws
    func deleteUser(userId: String) async throws
    func listenToUser(userId: String) -> AsyncThrowingStream<User, Error>
    func fetchUsers(by userIds: [String]) async throws -> [User]
    func fetchUser(by userId: String) async throws -> User
}
