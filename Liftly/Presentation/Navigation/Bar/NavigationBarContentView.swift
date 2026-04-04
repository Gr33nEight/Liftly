//
//  NavigationBarContentView.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import SwiftUI

struct NavigationBarContentView: View {
    @Binding var selected: TabDestination
    let container: AuthenticatedAppContainer
    var body: some View {
        TabView(selection: $selected) {
            ForEach(TabDestination.allCases, id:\.hashValue) { tab in
                ZStack {
                    switch tab {
                    case .home:
                        container.makeHomeView()
                    case .workout:
                        container.makeWorkoutView()
                    case .profile:
                        container.makeProfileView()
                    }
                }.tabItem {
                    Label(tab.rawValue, systemImage: tab.icon)
                }
            }
        }
    }
}
