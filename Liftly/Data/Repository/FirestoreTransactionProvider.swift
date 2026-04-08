//
//  FirestoreTransactionProvider.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//
import SwiftUI

final class FirestoreTransactionProvider: TransactionProvider {
    private let client: FirestoreClient

    init(client: FirestoreClient) {
        self.client = client
    }

    func runTransaction(
        _ block: @Sendable @escaping (Transaction) throws -> Void
    ) async throws {
        try await client.runTransaction(block)
    }
}
