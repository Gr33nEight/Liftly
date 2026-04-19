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
            dateCreated: domain.dateCreated,
            isPublic: domain.isPublic,
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
            dateCreated: entry.dateCreated,
            isPublic: entry.isPublic,
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
            dateCreated: dto.dateCreated,
            isPublic: dto.isPublic,
            description: dto.description,
            image: mapImage(dto.image),
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
    
    private static func mapImage(_ image: String?) -> URL? {
        guard let image else { return nil }
        
        let cleaned = image.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return URL(string: cleaned)
    }
    
    private static func mapImage(_ image: URL?) -> String? {
        return image?.absoluteString
    }
    
}
