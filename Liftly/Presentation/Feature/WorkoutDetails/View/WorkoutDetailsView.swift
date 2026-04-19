//
//  WorkoutDetailsView.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import SwiftUI

struct WorkoutDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: WorkoutDetailsViewModel
    var body: some View {
        VStack {
            header
            
        }
    }
}

extension WorkoutDetailsView {
    private var header: some View {
        ZStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Menu {
                    
                } label: {
                    Image(systemName: "ellipsis")
                }

            }
            Text("Log Workout")
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
        .background(Color.custom.darkerBackground)
    }
}

#Preview {
    WorkoutDetailsView(viewModel: WorkoutDetailsViewModel())
}
