//
//  TabDestination.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import SwiftUI

enum TabDestination: String, CaseIterable {
    case home
    case workout
    case profile
    
    var icon: String {
        switch self {
        case .home:
            return "house"
        case .workout:
            return "dumbbell"
        case .profile:
            return "person"
        }
    }
}
