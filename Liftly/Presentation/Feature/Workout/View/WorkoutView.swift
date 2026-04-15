//
//  WorkoutView.swift
//  Liftly
//
//  Created by Natanael Jop on 07/04/2026.
//

import SwiftUI

struct WorkoutView: View {
    @Environment(\.navigate) var navigate
    @StateObject var viewModel: WorkoutViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Workout")
                .font(.custom.largeTitle())
                .foregroundStyle(Color.custom.text)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    Button {
                        navigate(.push(.activeWorkout(routineId: nil)))
                    } label: {
                        Text("＋ Start Empty Workout")
                            .font(.custom.body())
                            .foregroundStyle(Color.custom.text)
                            .frame(maxWidth: .infinity)
                            .customBackground()
                    }
                    routinesView
                    myRoutinesView
                }
            }
        }.padding(.horizontal)
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
            Text("MY ROUTINES (\(viewModel.routines.count))")
                .font(.custom.bodyMedium())
                .foregroundStyle(Color.custom.tertiary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(viewModel.routines, id:\.id) { routine in
                RoutineCellView(routine: routine)
            }
        }.frame(maxWidth: .infinity)
    }
}

#Preview {
//    WorkoutView(viewModel: WorkoutViewModel(getExercisesUseCase: MockGetExercisesUseCase()))
//        .preferredColorScheme(.dark)
}
