//
//  ActiveWorkoutView.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import SwiftUI

struct ActiveWorkoutView: View {
    @StateObject var viewModel: ActiveWorkoutViewModel
    var body: some View {
        Text("Active Workout View")
    }
}

#Preview {
    ActiveWorkoutView(viewModel: ActiveWorkoutViewModel())
}
