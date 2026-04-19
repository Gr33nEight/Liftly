//
//  AuthenticatedAppRootView.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import SwiftUI

struct AuthenticatedAppRootView: View {
    @StateObject private var viewModel: AuthenticatedAppViewModel
    private let container: AuthenticatedAppContainer
    
    init(container: AuthenticatedAppContainer) {
        self.container = container
        self._viewModel = StateObject(wrappedValue: container.makeAuthenticatedAppViewModel())
    }
    
    var body: some View {
        NavigationStackContentView(container: container)
            .onAppear {
                viewModel.preloadExercises()
            }
    }
}

