//
//  FirestoreClient.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import FirebaseFirestore

protocol FirestoreClient {
    func fetch<E: FirestoreEndpoint>(
        _ endpoint: E.Type,
        query: FirestoreQuery
    ) async throws -> [E.DTO]
    
    func fetchDocument<E: FirestoreEndpoint>(
        _ endpoint: E.Type,
        id: FirestoreDocumentID
    ) async throws -> E.DTO
    
    func setData<E: FirestoreEndpoint>(
        _ dto: E.DTO,
        for endpoint: E.Type,
        id: FirestoreDocumentID,
        merge: Bool
    ) async throws
    
    func updateData<E: FirestoreEndpoint>(
        for endpoint: E.Type,
        id: FirestoreDocumentID,
        _ fields: [String : FirestoreUpdateOperations]
    ) async throws
    
    func delete<E: FirestoreEndpoint>(
        for endpoint: E.Type,
        id: FirestoreDocumentID,
    ) async throws
    
    func batchDelete<E: FirestoreEndpoint>(
        _ endpoint: E.Type,
        query: FirestoreQuery
    ) async throws
    
    func runBatch(
        _ block: (FirestoreBatch) -> Void
    ) async throws
    
    func listen<E: FirestoreEndpoint>(
        _ endpoint: E.Type,
        query: FirestoreQuery
    ) -> AsyncThrowingStream<[E.DTO], Error>
    
    func listenDocument<E: FirestoreEndpoint>(
        _ endpoint: E.Type,
        id: FirestoreDocumentID
    ) -> AsyncThrowingStream<E.DTO, Error>
    
    func create<E: FirestoreEndpoint>(
        _ dto: E.DTO,
        for endpoint: E.Type
    ) async throws -> FirestoreDocumentID
    
    func runTransaction(
        _ block: @Sendable @escaping (Transaction) throws -> Void
    ) async throws
}
