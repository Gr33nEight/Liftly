//
//  RoutineView.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import SwiftUI

struct RoutineView: View {
    @StateObject var viewModel: RoutineViewModel
    var body: some View {
        Text("Routine View")
    }
}

#Preview {
    RoutineView(viewModel: RoutineViewModel())
}
