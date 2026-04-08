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
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "xmark")
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
                    statCell("Duration", "\(viewModel.duration)")
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
                }
            } else {
                ScrollView {
                    ForEach(viewModel.trackedExercises) { ex in
                        
                    }
                }
            }
        }
        .background(Color.custom.background)
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
                
            }.customButtonStyle(.primary)
                .padding(.top)
            
            HStack {
                Button("Settings") {
                    
                }.customButtonStyle(.secondary)
                Button("Discard Workout") {
                    
                }.customButtonStyle(.secondary)
            }
        }.padding(.horizontal)
    }
}

#Preview {
    ActiveWorkoutView(viewModel: ActiveWorkoutViewModel(routineId: "123", createPostUseCase: MockCreatePostUseCase()))
        .preferredColorScheme(.dark)
}
