//
//  FirestoreEndpoint.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import Foundation

protocol FirestoreEndpoint {
    associatedtype DTO: Codable
    nonisolated static var path: String { get }
}
