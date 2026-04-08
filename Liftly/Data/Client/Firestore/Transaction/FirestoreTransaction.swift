//
//  FirestoreTransaction.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//

import FirebaseFirestore

final class FirestoreTransaction: Transaction {
    private let raw: FirebaseFirestore.Transaction
    private let db: Firestore
    
    init(raw: FirebaseFirestore.Transaction, db: Firestore = Firestore.firestore()) {
        self.raw = raw
        self.db = db
    }
    
    func setData<E>(_ dto: E.DTO, for endpoint: E.Type, id: FirestoreDocumentID) throws where E : FirestoreEndpoint{
        let ref = db.collection(endpoint.path).document(id.value)
        try raw.setData(from: dto, forDocument: ref)
    }
}
