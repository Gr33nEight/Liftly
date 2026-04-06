//
//  FirestoreClientImpl.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import Foundation
@preconcurrency import FirebaseFirestore

final class FirestoreClientImpl: FirestoreClient {
    private let db: Firestore
    
    init(db: Firestore = Firestore.firestore()) {
        self.db = db
    }
    
    func fetch<E>(
        _ endpoint: E.Type,
        quuery: FirestoreQuery
    ) async throws -> [E.DTO] where E : FirestoreEndpoint {
        let ref = handleQuery(quuery, path: endpoint.path)
        let snapshot = try await ref.getDocuments()
        return try snapshot.documents.compactMap {
            try $0.data(as: E.DTO.self)
        }
    }
    
    func fetchDocument<E>(
        _ endpoint: E.Type,
        id: FirestoreDocumentID
    ) async throws -> E.DTO where E : FirestoreEndpoint {
        let doc = try await db
            .collection(endpoint.path)
            .document(id.value)
            .getDocument()
        return try doc.data(as: E.DTO.self)
    }
    
    func setData<E>(
        _ dto: E.DTO,
        for endpoint: E.Type,
        id: FirestoreDocumentID,
        merge: Bool
    ) async throws where E : FirestoreEndpoint {
        let ref = db.collection(endpoint.path).document(id.value)
        try ref.setData(from: dto, merge: merge)
    }
    
    func updateData<E>(
        for endpoint: E.Type,
        id: FirestoreDocumentID,
        _ fields: [String : FirestoreUpdateOperations]
    ) async throws where E : FirestoreEndpoint {
        let ref = db.collection(endpoint.path).document(id.value)
        let data = FirestoreUpdateOperationsMapper.toUpdateData(fields)
        
        try await ref.updateData(data)
    }
    
    func delete<E>(
        for endpoint: E.Type,
        id: FirestoreDocumentID
    ) async throws where E : FirestoreEndpoint {
        let ref = db.collection(endpoint.path).document(id.value)
        try await ref.delete()
    }
    
    func listen<E>(
        _ endpoint: E.Type,
        query: FirestoreQuery
    ) -> AsyncThrowingStream<[E.DTO], Error> where E : FirestoreEndpoint {
        AsyncThrowingStream { continuation in
            let ref = handleQuery(query, path: endpoint.path)
            let listener = ref.addSnapshotListener { snapshot, error in
                if let error {
                    continuation.finish(throwing: error)
                    return
                }
                
                guard let snapshot else { return }
                
                do {
                    let data: [E.DTO] = try snapshot.documents.map {
                        try $0.data(as: E.DTO.self)
                    }
                    continuation.yield(data)
                } catch {
                    continuation.finish(throwing: error)
                    return
                }
            }
            continuation.onTermination = { @Sendable _ in
                listener.remove()
            }
        }
    }
    
    func listenDocument<E: FirestoreEndpoint>(
        _ endpoint: E.Type,
        id: FirestoreDocumentID
    ) -> AsyncThrowingStream<E.DTO, Error> {
        AsyncThrowingStream { continuation in
            let ref = db.collection(endpoint.path).document(id.value)
            let listener = ref.addSnapshotListener { snapshot, error in
                if let error {
                    continuation.finish(throwing: error)
                    return
                }

                guard snapshot?.exists == true, let snapshot else { return }

                do {
                    let data = try snapshot.data(as: E.DTO.self)
                    continuation.yield(data)
                } catch {
                    continuation.finish(throwing: error)
                }
            }
            continuation.onTermination = { @Sendable _ in
                listener.remove()
            }
        }
    }
    
    func create<E>(_ dto: E.DTO, for endpoint: E.Type) async throws -> FirestoreDocumentID where E : FirestoreEndpoint {
        let ref = db.collection(endpoint.path).document()
        try ref.setData(from: dto)
        
        return FirestoreDocumentID(value: ref.documentID)
    }
    
    private func handleQuery(_ query: FirestoreQuery, path: String) -> Query {
        var ref: Query = db.collection(path)
        
        for filter in query.filters {
            ref = applyFilter(ref, filter: filter)
        }
        
        if let order = query.order {
            ref = ref.order(by: order.field, descending: order.descending)
        }
        
        if let limit = query.limit {
            ref = ref.limit(to: limit)
        }
        
        return ref
    }
    
    private func applyFilter(
        _ ref: Query,
        filter: FirestoreFilter
    ) -> Query {
        
        switch filter {
            
        case .isEqual(let field, let value):
            return apply(
                ref,
                field: field,
                stringBlock: { $0.whereField($1, isEqualTo: value.raw) },
                documentIdBlock: { $0.whereField($1, isEqualTo: value.raw) }
            )
            
        case .arrayContains(let field, let value):
            return apply(
                ref,
                field: field,
                stringBlock: { $0.whereField($1, arrayContains: value.raw) },
                documentIdBlock: { $0.whereField($1, arrayContains: value.raw) }
            )
            
        case .greaterThan(let field, let value):
            return apply(
                ref,
                field: field,
                stringBlock: { $0.whereField($1, isGreaterThan: value.raw) },
                documentIdBlock: { $0.whereField($1, isGreaterThan: value.raw) }
            )
            
        case .lessThan(let field, let value):
            return apply(
                ref,
                field: field,
                stringBlock: { $0.whereField($1, isLessThan: value.raw) },
                documentIdBlock: { $0.whereField($1, isLessThan: value.raw) }
            )
            
        case .isIn(let field, let values):
            let rawValues = values.map { $0.raw }
            
            return apply(
                ref,
                field: field,
                stringBlock: { $0.whereField($1, in: rawValues) },
                documentIdBlock: { $0.whereField($1, in: rawValues) }
            )
        }
    }
    
    private func apply(
        _ ref: Query,
        field: FirestoreField,
        stringBlock: (Query, String) -> Query,
        documentIdBlock: (Query, FieldPath) -> Query
    ) -> Query {
        
        switch field {
        case .field(let name):
            return stringBlock(ref, name)
            
        case .documentId:
            return documentIdBlock(ref, FieldPath.documentID())
        }
    }
}
