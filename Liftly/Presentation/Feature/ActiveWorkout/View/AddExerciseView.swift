//
//  AddExerciseView.swift
//  Liftly
//
//  Created by Natanael Jop on 09/04/2026.
//

import SwiftUI

struct AddExerciseView: View {
    @Environment(\.dismiss) var dismiss
    @State var  selectedExercises: [Exercise] = []
    
    let type: ShowExerciseListType
    let exercises: [Exercise]
    var onDismiss: ([Exercise]) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    Spacer()
                    Button("Create") {
                        
                    }
                }
                Text("Add Exercise")
                    .font(.custom.bodyMedium())
                    .foregroundStyle(Color.custom.text)
            }.padding()
            .font(.custom.body())
                .background(Color.custom.darkerBackground)
            ZStack(alignment: .bottom) {
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(exercises, id: \.self) { exercise in
                            exerciseCell(for: exercise)
                                .onTapGesture {
                                    switch type {
                                    case .add:
                                        seleteToggle(exercise: exercise)
                                    case .replace(_):
                                        onDismiss([exercise])
                                        dismiss()
                                    }
                                }
                        }
                    }
                    .padding(.top)
                }
                if !selectedExercises.isEmpty {
                    Button("Add \(selectedExercises.count) Exercise\(selectedExercises.count == 1 ? "" : "s")") {
                        onDismiss(selectedExercises)
                        dismiss()
                    }.customButtonStyle(.primary)
                }
            }.padding(.horizontal)
        }
        .background(Color.custom.background)
    }
}

extension AddExerciseView {
    private func exerciseCell(for exercise: Exercise) -> some View {
        VStack(spacing: 15) {
            HStack(spacing: 10) {
                if selectedExercises.contains(exercise) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.custom.primary)
                        .frame(width: 5)
                        .padding(2)
                }
                ZStack {
                    Color.custom.tertiary.opacity(0.5)
                    Text("🏋")
                        .font(.title)
                        .shadow(radius: 5)
                }.frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                VStack(alignment: .leading) {
                    Text(exercise.title)
                        .font(.custom.bodyMedium())
                    Text(
                        exercise.primaryMuscleGroup.displayName +
                        " | " + exercise.exerciseType.displayName +
                        " | " + exercise.equipment.displayName
                    ).foregroundStyle(Color.custom.tertiary)
                        .font(.custom.subheadline())
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "chart.line.uptrend.xyaxis.circle")
                        .font(.title)
                }
            }
            Divider()
        }.padding(.bottom, 5)
    }
    
    private func seleteToggle(exercise: Exercise) {
        withAnimation {
            if selectedExercises.contains(exercise) {
                selectedExercises.removeAll(where: { $0.title == exercise.title })
            } else {
                selectedExercises.append(exercise)
            }
        }
    }
}

#Preview {
    AddExerciseView(type: .add, exercises: MockData.exercises, onDismiss: { _ in }).preferredColorScheme(.dark)
}
