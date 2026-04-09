//
//  WorkoutDetailsView.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import SwiftUI

struct WorkoutDetailsView: View {
    @StateObject var viewModel: WorkoutDetailsViewModel
    var body: some View {
        Text("Workout Details View")
    }
}

#Preview {
    WorkoutDetailsView(viewModel: WorkoutDetailsViewModel())
}
