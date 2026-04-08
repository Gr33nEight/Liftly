//
//  TransactionProvider.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import Foundation

protocol TransactionProvider {
    func runTransaction(
        _ block: @Sendable @escaping (Transaction) throws -> Void
    ) async throws
}
