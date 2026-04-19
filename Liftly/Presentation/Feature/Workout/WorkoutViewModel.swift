
//
//  WorkoutViewModel.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//

import SwiftUI
import Combine

@MainActor
final class WorkoutViewModel: ObservableObject {
    
    @Published var routines: [RoutineEntry] = []
    
    private let currentUserId: String
    private let getRoutinesUseCase: GetRoutinesUseCase
    
    init(
        currentUserId: String,
        getRoutinesUseCase: GetRoutinesUseCase
    ) {
        self.currentUserId = currentUserId
        self.getRoutinesUseCase = getRoutinesUseCase
    }
    
    func onAppear() async {
        await getRoutines()
    }
    
    private func getRoutines() async {
        do {
            self.routines = try await getRoutinesUseCase.execute(uid: currentUserId)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}



