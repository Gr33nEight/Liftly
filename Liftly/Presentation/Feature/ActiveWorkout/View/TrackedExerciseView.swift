//
//  TrackedExerciseView.swift
//  Liftly
//
//  Created by Natanael Jop on 09/04/2026.
//


import SwiftUI

struct TrackedExerciseView: View {
    @Binding var trackedExercise: TrackedExercise
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            // HEADER
            HStack {
                ZStack {
                    Color.custom.tertiary.opacity(0.5)
                    Text("🏋")
                        .font(.title)
                }
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text(trackedExercise.exercise.title)
                    .foregroundStyle(Color.custom.primary)
                    .font(.title3)
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                }
                .rotationEffect(.degrees(90))
            }
            
            // REST TIMER
            Button {
                // TODO: timer picker
            } label: {
                Label("Rest Timer: \(trackedExercise.restTime.format())", systemImage: "timer")
            }
            .font(.custom.body())
            .foregroundStyle(Color.custom.secondary)
            
            // TABLE HEADER
            LazyVGrid(columns: columns, spacing: 12) {
                Text("SET")
                
                if trackedExercise.hasWeight { Text("KG") }
                if trackedExercise.hasReps { Text("REPS") }
                if trackedExercise.hasDistance { Text("DIST") }
                if trackedExercise.hasDuration { Text("TIME") }
                
                Text("✔️")
            }
            .foregroundStyle(Color.custom.tertiary)
            .font(.custom.subheadline())
            
            ForEach($trackedExercise.sets) { $set in
                LazyVGrid(columns: columns, spacing: 12) {
                    
                    Text(set.type.displayedValue)
                    

                    if trackedExercise.hasWeight {
                        doubleField(value: $set.weight, placeholder: "kg").foregroundStyle(set.isDone ? Color.custom.text : Color.custom.tertiary)
                    }
                    
                    if trackedExercise.hasReps {
                        intField(value: $set.reps, placeholder: "reps").foregroundStyle(set.isDone ? Color.custom.text : Color.custom.tertiary)
                    }
                    
                    if trackedExercise.hasDistance {
                        intField(value: $set.distance, placeholder: "m").foregroundStyle(set.isDone ? Color.custom.text : Color.custom.tertiary)
                    }
                    
                    if trackedExercise.hasDuration {
                        intField(value: $set.seconds, placeholder: "s").foregroundStyle(set.isDone ? Color.custom.text : Color.custom.tertiary)
                    }

                    
                    Button {
                        set.isDone.toggle()
                    } label: {
                        Image(systemName: set.isDone ? "checkmark.square.fill" : "square")
                            .foregroundStyle(
                                set.isDone ? Color.custom.primary : Color.custom.tertiary
                            )
                    }
                }
            }
            
            // ADD SET
            Button("+ Add Set") {
                addSet()
            }
            .customButtonStyle(.primary)
            .padding(.top)
        }
        .padding()
    }
    
    private func addSet() {
        let newSet = ExerciseSet.create(
            type: .normal(trackedExercise.sets.count + 1),
            exerciseType: trackedExercise.exercise.exerciseType
        )
        trackedExercise.sets.append(newSet)
    }
    
    private var columns: [GridItem] {
        var cols: [GridItem] = [
            GridItem(.fixed(40)) // SET
        ]
        
        if trackedExercise.hasWeight {
            cols.append(GridItem(.flexible()))
        }
        if trackedExercise.hasReps {
            cols.append(GridItem(.flexible()))
        }
        if trackedExercise.hasDistance {
            cols.append(GridItem(.flexible()))
        }
        if trackedExercise.hasDuration {
            cols.append(GridItem(.flexible()))
        }
        
        cols.append(GridItem(.fixed(40)))
        
        return cols
    }
    
    private func doubleField(
        value: Binding<Double?>,
        placeholder: String
    ) -> some View {
        TextField(
            placeholder,
            value: Binding(
                get: { value.wrappedValue ?? 0 },
                set: { value.wrappedValue = $0 }
            ),
            format: .number
        )
        .keyboardType(.decimalPad)
        .frame(width: 50)
        .multilineTextAlignment(.center)
    }
    private func intField(
        value: Binding<Int?>,
        placeholder: String,
    ) -> some View {
        TextField(
            placeholder,
            value: Binding(
                get: { value.wrappedValue ?? 0 },
                set: { value.wrappedValue = $0 }
            ),
            format: .number
        )
        .keyboardType(.numberPad)
        .frame(width: 50)
        .multilineTextAlignment(.center)
    }
}
