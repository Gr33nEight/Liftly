//
//  AppContainer.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import SwiftUI

final class AppContainer {
    lazy private var authClient: AuthClient = AuthClientImpl()
    lazy private var firestoreClient: FirestoreClient = FirestoreClientImpl()
    
    lazy private var authRepository: AuthRepository = AuthRepositoryImpl(authClient: authClient, firestoreClient: firestoreClient)
    
    lazy private var observeSession: ObserveSessionUseCase = ObserveSessionUseCaseImpl(authRepository: authRepository)
    
    @MainActor
    private func makeSessionViewModel() -> SessionViewModel {
        SessionViewModel(observeSession: observeSession)
    }
    
    @MainActor
    func makeAppEntry() -> some View {
        AppEntry(viewModel: self.makeSessionViewModel())
    }
}
