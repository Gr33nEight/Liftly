//
//  NavigationAction.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import Foundation

enum NavigationAction {
    case push(Route)
    case unwind(Route?)
}
