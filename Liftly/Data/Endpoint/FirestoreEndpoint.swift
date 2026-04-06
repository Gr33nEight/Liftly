//
//  FirestoreEndpoint.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import Foundation

protocol FirestoreEndpoint: Sendable {
    associatedtype DTO: Codable & Sendable
    static var path: String { get }
}
