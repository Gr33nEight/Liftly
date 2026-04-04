//
//  UnAuthenticatedAppRootView.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import SwiftUI

struct UnAuthenticatedAppRootView: View {
    private let container: UnAuthenticatedAppContainer
    
    init(container: UnAuthenticatedAppContainer) {
        self.container = container
    }
    
    var body: some View {
        Text("UnAuthenticated")
            .font(.title)
    }
}
