//
//  RoutineRepositoryImpl.swift
//  Liftly
//
//  Created by Natanael Jop on 14/04/2026.
//

import Foundation

final class RoutineRepositoryImpl: RoutineRepository {
    private let firestoreClient: FirestoreClient
    
    init(firestoreClient: FirestoreClient) {
        self.firestoreClient = firestoreClient
    }
    
    func fetchRoutines(for uid: String) async throws -> [Routine] {
        let query = FirestoreQuery().isEqual(.field("ownerId"), .string(uid))
        let dtos = try await firestoreClient.fetch(RoutineEndpoint.self, query: query)
        return try dtos.map(RoutineMapper.toDomain(_:))
    }
    
    func fetchRoutine(with id: String) async throws -> Routine {
        let dto = try await firestoreClient.fetchDocument(RoutineEndpoint.self, id: .init(value: id))
        return try RoutineMapper.toDomain(dto)
    }
}
