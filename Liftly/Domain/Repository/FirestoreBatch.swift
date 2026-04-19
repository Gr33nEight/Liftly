//
//  FirestoreBatch.swift
//  Liftly
//
//  Created by Natanael Jop on 13/04/2026.
//

import Foundation

protocol FirestoreBatch {
    func delete<E: FirestoreEndpoint>(
        for endpoint: E.Type,
        id: FirestoreDocumentID,
    )
}
