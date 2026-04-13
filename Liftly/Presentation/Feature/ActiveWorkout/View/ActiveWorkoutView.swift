//
//  ActiveWorkoutView.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import SwiftUI

struct ActiveWorkoutView: View {
    @StateObject var viewModel: ActiveWorkoutViewModel

    @State private var showExericseListType: ShowExerciseListType?
    @State private var showSaveWorkoutView: Bool = false
    @State private var shouldCloseFlow = false
    
    private var progress: CGFloat {
        guard viewModel.totalRestTime > 0 else { return 0 }
        return CGFloat(viewModel.restTime) / CGFloat(viewModel.totalRestTime)
    }
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.navigate) var navigate
    
    let generator = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                ZStack {
                    HStack {
                        Button {
                            navigate(.unwind(nil))
                        } label: {
                            Image(systemName: "chevron.left")
                        }
                        Spacer()
                        Button("Finish") {
                            showSaveWorkoutView.toggle()
                        }.customButtonStyle(.primary)
                            .frame(width: 80)
                    }
                    Text("Log Workout")
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                .background(Color.custom.darkerBackground)
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
                        LazyVStack(spacing: 20) {
                            ForEach($viewModel.trackedExercises) { $ex in
                                TrackedExerciseView(trackedExercise: $ex) { id in
                                    viewModel.removeExercise(id)
                                } onExerciseReplace: { id in
                                    showExericseListType = .replace(id)
                                } onDone: { time in
                                    generator.impactOccurred()
                                    viewModel.startRestTimer(time: time)
                                }

                            }
                            defaultButtons.padding(.horizontal)
                        }.padding(.top, 20)
                    }
                }
            }
            if viewModel.isRestRunning {
                VStack {
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.custom.secondary.opacity(0.2))
                            
                            Rectangle()
                                .fill(Color.custom.primary)
                                .frame(width: geo.size.width * progress)
                                .animation(.linear(duration: 1), value: progress)
                        }
                    }
                    .frame(height: 6)
                    
                    HStack {
                        Spacer()
                        
                        Button("-15") {
                            viewModel.subtractRestTime(15)
                        }
                        .frame(width: 70)
                        .customButtonStyle(.secondary)
                        
                        Spacer()
                        
                        TimelineView(.periodic(from: .now, by: 1)) { _ in
                            Text(viewModel.restTime.format())
                                .font(.custom.title())
                                .monospacedDigit()
                        }
                        
                        Spacer()
                        
                        Button("+15") {
                            viewModel.addRestTime(15)
                        }
                        .frame(width: 70)
                        .customButtonStyle(.secondary)
                        
                        Button("Skip") {
                            viewModel.stopRestTimer()
                        }
                        .frame(width: 70)
                        .customButtonStyle(.primary)
                        
                        Spacer()
                    }
                }.transition(.move(edge: .bottom).combined(with: .opacity))
                    .background(Color.custom.darkerBackground)
                
            }
        }.task {
            await viewModel.startWorkout()
        }
        .background(Color.custom.background)
        .navigationBarBackButtonHidden()
        .fullScreenCover(item: $showExericseListType) { type in
            AddExerciseView(type: type, exercises: viewModel.exercises) { selectedExercises in
                switch type {
                case .add: viewModel.addTrackedExercises(for: selectedExercises)
                case .replace(let id):
                    viewModel.removeExercise(id)
                    viewModel.addTrackedExercises(for: selectedExercises)
                }
            }
        }
        .fullScreenCover(isPresented: $showSaveWorkoutView) {
            SaveWorkoutView(viewModel: viewModel) {
                shouldCloseFlow = true
            }
        }
        .onChange(of: showSaveWorkoutView) { _, isPresented in
            guard !isPresented && shouldCloseFlow else { return }
            dismiss()
            shouldCloseFlow = false
        }
        .onChange(of: shouldCloseFlow) { _, shouldClose in
            guard shouldClose else { return }
            
            showSaveWorkoutView = false
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
            defaultButtons
        }.padding(.horizontal)
    }
    
    private var defaultButtons: some View {
        VStack(spacing: 12) {
            Button("Add exercise") {
                showExericseListType = .add
            }.customButtonStyle(.primary)
                .padding(.top)
            
            HStack {
                Button("Settings") {
                    
                }.customButtonStyle(.secondary)
                Button("Discard Workout") {
                    
                }.customButtonStyle(.secondary, textColor: .red)
            }
        }
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
    ActiveWorkoutView(viewModel: ActiveWorkoutViewModel(currentUserId: "",routineId: "", createPostUseCase: MockCreatePostUseCase(), getExercisesUseCase: MockGetExercisesUseCase()))
        .preferredColorScheme(.dark)
}

