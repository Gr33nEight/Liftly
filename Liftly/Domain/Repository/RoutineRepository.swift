//
//  RoutineRepository.swift
//  Liftly
//
//  Created by Natanael Jop on 14/04/2026.
//

import Foundation

protocol RoutineRepository {
    func fetchRoutines(for uid: String) async throws -> [Routine]
    func fetchRoutine(with id: String) async throws -> Routine
}
