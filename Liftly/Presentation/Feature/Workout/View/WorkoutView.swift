//
//  WorkoutView.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//

import SwiftUI

struct WorkoutView: View {
    @StateObject var viewModel: WorkoutViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("Workout")
                .font(.custom.largeTitle())
                .foregroundStyle(Color.custom.text)
            routinesView
            myRoutinesView
        }.padding()
        .frame(maxWidth: .infinity)
        .background(Color.custom.background)
        .task {
            await viewModel.onAppear()
        }
    }
}

extension WorkoutView {
    private var routinesView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("ROUTINES")
                .font(.custom.bodyMedium())
                .foregroundStyle(Color.custom.tertiary)
            HStack {
                Button {
                    
                } label: {
                    Text("📋  New Routine")
                        .font(.custom.body())
                        .foregroundStyle(Color.custom.text)
                        .frame(maxWidth: .infinity)
                        .customBackground()
                }

                Button {
                    
                } label: {
                    Text("🔍  Explore")
                        .font(.custom.body())
                        .foregroundStyle(Color.custom.text)
                        .frame(maxWidth: .infinity)
                        .customBackground()
                }

            }
        }
    }
    
    private var myRoutinesView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("MY ROUTINES (3)")
                .font(.custom.bodyMedium())
                .foregroundStyle(Color.custom.tertiary)
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.routines) { routine in
                    RoutineCellView(routine: routine)
                }
            }
        }
    }
}

#Preview {
    WorkoutView(viewModel: WorkoutViewModel(getExercisesUseCase: MockGetExercisesUseCase()))
        .preferredColorScheme(.dark)
}
