//
//  StorageRepository.swift
//  Liftly
//
//  Created by Natanael Jop on 14/04/2026.
//

import Foundation

protocol StorageRepository {
    func uploadImage(data: Data, path: StoragePath) async throws -> URL
    func deleteImage(path: StoragePath) async throws
}
