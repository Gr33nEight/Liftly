//
//  FirebaseStorageClient.swift
//  Liftly
//
//  Created by Natanael Jop on 14/04/2026.
//

import Foundation

protocol FirebaseStorageClient {
    func uploadData(_ data: Data, path: StoragePath) async throws -> URL
    func delete(path: StoragePath) async throws
    func getDownloadURL(path: StoragePath) async throws -> URL
}

