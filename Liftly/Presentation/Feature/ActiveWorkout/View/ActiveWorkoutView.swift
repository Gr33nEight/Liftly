//
//  ActiveWorkoutView.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import SwiftUI

struct ActiveWorkoutView: View {
    @StateObject var viewModel: ActiveWorkoutViewModel
    @State private var showAddExericseView: Bool = false
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    Spacer()
                    Button("Finish") {
                        
                    }.customButtonStyle(.primary)
                        .frame(width: 80)
                }
                Text("Log Workout")
            }.padding([.horizontal, .bottom])
            VStack(spacing: 16) {
                Divider()
                HStack {
                    TimelineView(.periodic(from: .now, by: 1)) { _ in
                        statCell("Duration", "\(viewModel.duration.format())")
                    }
                    statCell("Volume", "\(viewModel.totalVolume)kg")
                    statCell("Sets", "\(viewModel.totalSets)")
                }.padding(.horizontal)
                Divider()
            }
            if viewModel.trackedExercises.isEmpty {
                VStack {
                    Spacer()
                    getStartedView
                    Spacer()
                }.padding(.bottom, 30)
            } else {
                ScrollView {
                    ForEach($viewModel.trackedExercises) { $ex in
                        TrackedExerciseView(trackedExercise: $ex)
                    }
                }
            }
        }.task {
            await viewModel.startWorkout()
        }
        .background(Color.custom.background)
        .navigationBarBackButtonHidden()
        .fullScreenCover(isPresented: $showAddExericseView) {
            AddExerciseView(exercises: viewModel.exercises) { selectedExercises in
                viewModel.addTrackedExercises(for: selectedExercises)
            }
        }
    }
}

extension ActiveWorkoutView {
    private func statCell(_ title: String, _ value: String) -> some View {
        HStack {
            Spacer()
            VStack(alignment: .center, spacing: 8) {
                Text(title)
                    .font(.custom.footnote())
                    .foregroundStyle(Color.custom.tertiary)
                Text(value)
                    .font(.custom.bodyMedium())
                    .foregroundStyle(Color.custom.secondary)
            }
            Spacer()
        }
    }
    
    private var getStartedView: some View {
        VStack(spacing: 12) {
            Image(systemName: "dumbbell")
                .font(.system(size: 40))
                .foregroundStyle(Color.custom.primary)
            Text("Get started")
                .font(.custom.bodyMedium())
                .foregroundStyle(Color.custom.text)
            Text("Add an exercise to start your workout")
                .font(Font.custom.footnote())
                .foregroundStyle(Color.custom.tertiary)
            Button("Add exercise") {
                showAddExericseView.toggle()
            }.customButtonStyle(.primary)
                .padding(.top)
            
            HStack {
                Button("Settings") {
                    
                }.customButtonStyle(.secondary)
                Button("Discard Workout") {
                    
                }.customButtonStyle(.secondary, textColor: .red)
            }
        }.padding(.horizontal)
    }
}

extension Int {
    func format() -> String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let secs = self % 60
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, secs)
        } else {
            return String(format: "%02d:%02d", minutes, secs)
        }
    }
}

#Preview {
    ActiveWorkoutView(viewModel: ActiveWorkoutViewModel(routineId: "", createPostUseCase: MockCreatePostUseCase(), getExercisesUseCase: MockGetExercisesUseCase()))
        .preferredColorScheme(.dark)
}
