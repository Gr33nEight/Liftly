//
//  SessionViewModel.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import SwiftUI
import Combine

@MainActor
final class SessionViewModel: ObservableObject {
    enum SessionState {
        case loading
        case authenticated(AuthenticatedAppContainer)
        case unauthenticated(UnAuthenticatedAppContainer)
    }
    
    @Published private(set) var state: SessionState = .loading
    
    private let observeSession: ObserveSessionUseCase
    private var task: Task<Void, Never>?
    
    init(observeSession: ObserveSessionUseCase) {
        self.observeSession = observeSession
        
        start()
    }
    
    deinit {
        task?.cancel()
    }
    
    private func start() {
        task = Task {
            for await session in observeSession.stream() {
                switch session {
                case .loggedOut:
                    state = .unauthenticated(UnAuthenticatedAppContainer())
                case .loggedIn(let uid):
                    state = .authenticated(AuthenticatedAppContainer(currentUserId: uid))
                }
            }
        }
    }
}
