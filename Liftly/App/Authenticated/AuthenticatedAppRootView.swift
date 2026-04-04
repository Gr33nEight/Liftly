//
//  AuthenticatedAppRootView.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import SwiftUI

struct AuthenticatedAppRootView: View {
    private let container: AuthenticatedAppContainer
    
    init(container: AuthenticatedAppContainer) {
        self.container = container
    }
    
    var body: some View {
        NavigationStackContentView(container: container)
    }
}

