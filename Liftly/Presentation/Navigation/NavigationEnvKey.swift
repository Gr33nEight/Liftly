//
//  NavigationEnvKey.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import SwiftUI

struct NavigationEnvironmentKey: EnvironmentKey {
    static var defaultValue: (NavigationAction) -> Void = { _ in } 
}

extension EnvironmentValues {
    var navigate: (NavigationAction) -> Void {
        get { self[NavigationEnvironmentKey.self] }
        set { self[NavigationEnvironmentKey.self] = newValue }
    }
}
