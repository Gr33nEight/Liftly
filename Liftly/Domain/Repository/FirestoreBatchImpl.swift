//
//  FirestoreBatchImpl.swift
//  Liftly
//
//  Created by Natanael Jop on 13/04/2026.
//

import SwiftUI
import FirebaseFirestore

final class FirestoreBatchImpl: FirestoreBatch {
    private let db: Firestore
    private let batch: WriteBatch
    
    init(db: Firestore, batch: WriteBatch) {
        self.db = db
        self.batch = batch
    }
    
    func delete<E>(for endpoint: E.Type, id: FirestoreDocumentID) where E : FirestoreEndpoint {
        let doc = db.collection(endpoint.path).document(id.value)
        batch.deleteDocument(doc)
    }
}
