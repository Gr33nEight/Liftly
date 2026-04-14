//
//  StorageRepository.swift
//  Liftly
//
//  Created by Natanael Jop on 14/04/2026.
//

import Foundation

final class StorageRepositoryImpl: StorageRepository {
    private let storageClient: FirebaseStorageClient
    
    init(storageClient: FirebaseStorageClient) {
        self.storageClient = storageClient
    }
    
    func uploadImage(data: Data, path: StoragePath) async throws -> URL {
        try await storageClient.uploadData(data, path: path)
    }
    
    func deleteImage(path: StoragePath) async throws {
        try await storageClient.delete(path: path)
    }
}
