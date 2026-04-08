//
//  Transaction.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//

import Foundation

protocol Transaction {
    func setData<E: FirestoreEndpoint>(
        _ dto: E.DTO,
        for endpoint: E.Type,
        id: FirestoreDocumentID
    ) throws
}
