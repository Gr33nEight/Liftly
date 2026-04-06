//
//  AuthenticatedAppContainer.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import SwiftUI

final class AuthenticatedAppContainer {
    lazy private var authClient: AuthClient = AuthClientImpl()
    lazy private var firestoreClient: FirestoreClient = FirestoreClientImpl()
    
    lazy private var authRepository: AuthRepository = AuthRepositoryImpl(authClient: authClient)
    
    lazy private var signOutUseCase: SignOutUseCase = SignOutUseCaseImpl(authRepository: authRepository)
    
    let currentUserId: String
    
    init(currentUserId: String) {
        self.currentUserId = currentUserId
    }
    
    @MainActor
    func makeHomeView() -> some View {
        VStack {
            Text("Home View")
            Button("Sign Out") {
                do {
                    try self.signOutUseCase.execute()
                } catch {
                    print("Error: ", error.localizedDescription)
                }
            }
        }.padding(20)
    }
    
    @MainActor
    func makeWorkoutView() -> some View {
        Text("Workout View")
    }
    
    @MainActor
    func makeProfileView() -> some View {
        Text("Profile View")
    }
    
    @MainActor
    func makeActiveWorkoutView() -> some View {
        Text("Active Workout View")
    }
    
    @MainActor
    func makeCommentsView() -> some View {
        Text("Comments View")
    }
    
    @MainActor
    func makeOtherProfileView() -> some View {
        Text("Other Profile View")
    }
    
    @MainActor
    func makeRoutineView() -> some View {
        Text("Routine View")
    }
    
    @MainActor
    func makeWorkoutDetailView() -> some View {
        Text("Workout Detail View")
    }
    
}
