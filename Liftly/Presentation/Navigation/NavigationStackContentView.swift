//
//  NavigationStackContentView.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import SwiftUI

struct NavigationStackContentView: View {
    let container: AuthenticatedAppContainer
    
    @State private var path = [Route]()
    @State private var selected: TabDestination = .home
    
    var body: some View {
        NavigationStack(path: $path) {
            NavigationBarContentView(selected: $selected, container: container)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .activeWorkout: container.makeActiveWorkoutView()
                    case .comments: container.makeCommentsView()
                    case .otherProfile: container.makeOtherProfileView()
                    case .routine: container.makeRoutineView()
                    case .workoutDetail: container.makeWorkoutDetailView()
                    }
                }
        }
    }
}
