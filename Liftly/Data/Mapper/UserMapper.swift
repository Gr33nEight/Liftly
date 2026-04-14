//
//  UserMapper.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import Foundation


enum UserMapper{
    static func toDTO(_ domain: User) -> UserDTO {
        return UserDTO(
            id: domain.id,
            name: domain.name,
            email: domain.email,
            followersIds: domain.followersIds,
            followingIds: domain.followingIds
        )
    }
    
    static func toDomain(_ dto: UserDTO) throws -> User {
        guard let id = dto.id else {
            throw MapperError.missingId
        }
        
        return User(
            id: id,
            name: dto.name,
            email: dto.email,
            followersIds: dto.followersIds,
            followingIds: dto.followingIds
        )
    }
    
    static func toStream(_ stream: AsyncThrowingStream<UserDTO, Error>) -> AsyncThrowingStream<User, Error> {
        AsyncThrowingStream { continuation in
            let task = Task {
                do {
                    for try await dto in stream {
                        try continuation.yield(UserMapper.toDomain(dto))
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
            
            continuation.onTermination = { _ in
                task.cancel()
            }
        }
    }
}
