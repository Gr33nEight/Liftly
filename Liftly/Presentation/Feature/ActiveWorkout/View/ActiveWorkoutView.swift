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
    
    let generator = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                header
                VStack(spacing: 16) {
                    Divider()
                    HStack {
                        TimelineView(.periodic(from: .now, by: 1)) { _ in
                            statCell("Duration", "\(viewModel.duration.formatIntoTime())")
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
                            .padding(.bottom, 80)
                    }
                }
            }
            if viewModel.isRestRunning {
                timer
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
    private var header: some View {
        ZStack {
            HStack {
                Button {
                    dismiss()
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
    }
    
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
    
    private var timer: some View {
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
                    Text(viewModel.restTime.formatIntoTime())
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
            .padding(.bottom, 5)
            .background(Color.custom.darkerBackground)

    }
}


//#Preview {
//    ActiveWorkoutView(viewModel: ActiveWorkoutViewModel(currentUserId: "",routineId: "", createPostUseCase: MockCreatePostUseCase(), getExercisesUseCase: MockGetExercisesUseCase()))
//        .preferredColorScheme(.dark)
//}

