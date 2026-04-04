//
//  ContentView.swift
//  Liftly
//
//  Created by Natanael Jop on 01/04/2026.
//

import SwiftUI

struct AppEntry: View {
    @StateObject var viewModel: SessionViewModel
    var body: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .authenticated(let authenticatedAppContainer):
            AuthenticatedAppRootView(container: authenticatedAppContainer)
        case .unauthenticated(let unAuthenticatedAppContainer):
            UnAuthenticatedAppRootView(container: unAuthenticatedAppContainer)
        }
    }
}
