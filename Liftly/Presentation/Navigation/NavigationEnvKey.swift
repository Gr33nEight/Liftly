//
//  NavigationEnvKey.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import SwiftUI

@MainActor
struct NavigationEnvironmentKey: EnvironmentKey {
    static let defaultValue: (NavigationAction) -> Void = { _ in }
}

@MainActor
extension EnvironmentValues {
    var navigate: (NavigationAction) -> Void {
        get { self[NavigationEnvironmentKey.self] }
        set { self[NavigationEnvironmentKey.self] = newValue }
    }
}
