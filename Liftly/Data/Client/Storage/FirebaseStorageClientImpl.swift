//
//  FirebaseStorageClientImpl.swift
//  Liftly
//
//  Created by Natanael Jop on 14/04/2026.
//

import Foundation
@preconcurrency import FirebaseStorage


final class FirebaseStorageClientImpl: FirebaseStorageClient {
    private let storage: Storage
    
    init(storage: Storage = Storage.storage()) {
        self.storage = storage
    }
    
    func uploadData(_ data: Data, path: StoragePath) async throws -> URL {
        let ref = storage.reference(withPath: path.value)
        
        _ = try await ref.putDataAsync(data)
        
        return try await ref.downloadURL()
    }
    
    func delete(path: StoragePath) async throws {
        let ref = storage.reference(withPath: path.value)
        try await ref.delete()
    }
    
    func getDownloadURL(path: StoragePath) async throws -> URL {
        let ref = storage.reference(withPath: path.value)
        return try await ref.downloadURL()
    }
}
