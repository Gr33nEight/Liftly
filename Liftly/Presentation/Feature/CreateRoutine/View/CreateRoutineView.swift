//
//  RoutineView.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import SwiftUI

struct CreateRoutineView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: CreateRoutineViewModel
    
    @State private var showExericseListType: ShowExerciseListType?
    @State private var title: String = ""
    
    var body: some View {
        VStack(spacing: 15) {
            header
            TextField("", text: $title, prompt:
                Text("Routine title")
                .foregroundColor(Color.custom.tertiary)
                .font(.custom.title())
            ).foregroundColor(Color.custom.text)
                .font(.custom.title())
                .padding(.horizontal)
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.custom.tertiary)
                .padding(.horizontal)

            if viewModel.trackedExercises.isEmpty {
                emptyTrackedExercisesView
            }else{
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 20) {
                        ForEach($viewModel.trackedExercises) { $ex in
                            TrackedExerciseView(isRoutineView: true, trackedExercise: $ex) { id in
                                viewModel.removeExercise(id)
                            } onSetRemove: { setId, exerciseId in
                                viewModel.removeSetFromExercise(setId: setId, exerciseId: exerciseId)
                            } onExerciseReplace: { id in
                                showExericseListType = .replace(id)
                            } onDone: {_ in}
                            Button("Add exercise") {
                                showExericseListType = .add
                            }.customButtonStyle(.primary)
                                .padding(.horizontal)
                        }
                        
                    }.padding(.top, 20)
                }
            }
        }.background(Color.custom.background)
            .task {
                await viewModel.onAppear()
            }
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
            .navigationBarBackButtonHidden()
    }
}

extension CreateRoutineView {
    private var header: some View {
        ZStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Button("Save") {
                    Task {
                        await viewModel.saveRoutine(title: title)
                    }
                    dismiss()
                }.customButtonStyle(.primary)
                    .frame(width: 80)
            }
            Text("Log Workout")
                .foregroundStyle(Color.custom.text)
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
        .background(Color.custom.darkerBackground.edgesIgnoringSafeArea(.top))
        
    }
    private var emptyTrackedExercisesView: some View {
        VStack(spacing: 20) {
            Image(systemName: "dumbbell")
                .font(.system(size: 40))
                .foregroundStyle(Color.custom.primary)
            Text("Get started by adding an exercise\nto your routine.")
                .multilineTextAlignment(.center)
                .font(Font.custom.bodyLight())
                .foregroundStyle(Color.custom.tertiary)
            Button("Add exercise") {
                showExericseListType = .add
            }.customButtonStyle(.primary)
        }.padding(.horizontal)
            .frame(maxHeight: .infinity)
            .padding(.bottom, 100)
    }
}

#Preview {
    CreateRoutineView(viewModel: CreateRoutineViewModel(currentUserId: "", getExercisesUseCase: MockGetExercisesUseCase(), saveRoutineUseCase: MockSaveRoutineUseCase()))
        .preferredColorScheme(.dark)
}
