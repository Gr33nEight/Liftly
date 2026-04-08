//
//  PostMapper.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//

import Foundation

enum PostMapper {
    static func toDTO(_ domain: Post) -> PostDTO {
        return PostDTO(
            id: domain.id,
            ownerId: domain.ownerId,
            title: domain.title,
            description: domain.description,
            image: mapImage(domain.image),
            likedUsersIds: domain.likedUsersIds,
            commentsIds: domain.commentsIds,
            workoutId: domain.workoutId
        )
    }
    
    static func toDTO(_ entry: PostEntry) -> PostDTO {
        return PostDTO(
            id: entry.id,
            ownerId: entry.ownerId,
            title: entry.title,
            description: entry.description,
            image: mapImage(entry.image),
            likedUsersIds: entry.likedUsersIds,
            commentsIds: entry.commentsIds,
            workoutId: entry.workout.id
        )
    }
    
    static func toDomain(_ dto: PostDTO) throws -> Post {
        guard let id = dto.id else {
            throw MapperError.missingId
        }
        
        return Post(
            id: id,
            ownerId: dto.ownerId,
            title: dto.title,
            description: dto.description,
            likedUsersIds: dto.likedUsersIds,
            commentsIds: dto.commentsIds,
            workoutId: dto.workoutId
        )
    }
    
    static func toStream(_ stream: AsyncThrowingStream<PostDTO, Error>) -> AsyncThrowingStream<Post, Error> {
        AsyncThrowingStream { continuation in
            let task = Task {
                do {
                    for try await dto in stream {
                        try continuation.yield(PostMapper.toDomain(dto))
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
    
    static func toStream(_ stream: AsyncThrowingStream<[PostDTO], Error>) -> AsyncThrowingStream<[Post], Error> {
        AsyncThrowingStream { continuation in
            let task = Task {
                do {
                    for try await dtos in stream {
                        continuation.yield(try dtos.map({ try PostMapper.toDomain($0) }))
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
    
    private static func mapImage(_ dto: PostDTO) -> URL? {
        return URL(string: dto.image)
    }
    
    private static func mapImage(_ image: URL?) -> String {
        return image?.absoluteString ?? ""
    }
    
}
