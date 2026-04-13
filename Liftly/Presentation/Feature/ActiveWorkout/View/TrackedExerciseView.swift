//
//  TrackedExerciseView.swift
//  Liftly
//
//  Created by Natanael Jop on 09/04/2026.
//


import SwiftUI

struct TrackedExerciseView: View {
    @Binding var trackedExercise: TrackedExercise
    @State private var showTimerModal: Bool = false
    
    var onExerciseRemove: (String) -> Void
    var onExerciseReplace: (String) -> Void
    var onDone: (Int) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            // HEADER
            HStack(spacing: 15) {
                ZStack {
                    Color.custom.tertiary.opacity(0.5)
                    Text("🏋")
                        .font(.title)
                }
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text(trackedExercise.exercise.title)
                    .foregroundStyle(Color.custom.primary)
                    .font(.custom.title2())
                
                Spacer()
                
                Menu("", systemImage: "ellipsis") {
                    Button(action: {
                        onExerciseReplace(trackedExercise.id)
                    }, label: {
                        Text("Replace Exercise")
                        Image(systemName: "arrow.triangle.2.circlepath")
                    })
                    Button(role: .destructive, action: {
                        onExerciseRemove(trackedExercise.id)
                    }, label: {
                        Text("Remove Exercise")
                        Image(systemName: "xmark")
                    })
                }
            }.padding(.horizontal)
            
            // REST TIMER
            Button {
                showTimerModal.toggle()
            } label: {
                Label("Rest Timer: \(trackedExercise.restTime.format())", systemImage: "timer")
            }
            .font(.custom.body())
            .foregroundStyle(Color.custom.secondary)
            .padding(.horizontal)
            
            // TABLE HEADER
            LazyVGrid(columns: columns, spacing: 12) {
                Text("SET")
                
                if trackedExercise.hasWeight { Text("KG") }
                if trackedExercise.hasReps { Text("REPS") }
                if trackedExercise.hasDistance { Text("DIST") }
                if trackedExercise.hasDuration { Text("TIME") }
                
                Image(systemName: "checkmark").font(.title3).bold()
            }.padding(.horizontal)
            .foregroundStyle(Color.custom.tertiary)
            .font(.custom.subheadline())
            
            VStack(spacing: 4) {
                ForEach($trackedExercise.sets) { $set in
                    LazyVGrid(columns: columns, spacing: 12) {
                        
                        Text(set.type.displayedValue).bold()
                        

                        if trackedExercise.hasWeight {
                            doubleField(value: $set.weight, placeholder: "kg").foregroundStyle(set.isDone ? Color.custom.text : Color.custom.tertiary.opacity(0.5))
                        }
                        
                        if trackedExercise.hasReps {
                            intField(value: $set.reps, placeholder: "reps").foregroundStyle(set.isDone ? Color.custom.text : Color.custom.tertiary.opacity(0.5))
                        }
                        
                        if trackedExercise.hasDistance {
                            intField(value: $set.distance, placeholder: "m").foregroundStyle(set.isDone ? Color.custom.text : Color.custom.tertiary.opacity(0.5))
                        }
                        
                        if trackedExercise.hasDuration {
                            intField(value: $set.seconds, placeholder: "s").foregroundStyle(set.isDone ? Color.custom.text : Color.custom.tertiary.opacity(0.5))
                        }

                        
                        Button {
                            set.isDone.toggle()
                            if set.isDone {
                                onDone(trackedExercise.restTime)
                            }
                        } label: {
                            Image(systemName: set.isDone ? "checkmark.square.fill" : "square")
                                .foregroundStyle(
                                    set.isDone ? Color.custom.primary : Color.custom.tertiary
                                )
                                .font(.title)
                        }
                    }.padding()
                    .background(Color.custom.tertiary.opacity(0.1))
                }.font(.custom.metricSmall())
            }.sheet(isPresented: $showTimerModal) {
                TimerView(trackedExercise: $trackedExercise)
                    .presentationDetents([.fraction(0.5)])
            }
            
            // ADD SET
            Button("+ Add Set") {
                addSet()
            }
            .customButtonStyle(.secondary)
            .padding([.top, .horizontal])
        }
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
            text: Binding(
                get: {
                    guard let value = value.wrappedValue else { return "" }
                    return value == 0 ? "" : String(value)
                },
                set: { newValue in
                    if newValue.isEmpty {
                        value.wrappedValue = nil
                    } else {
                        value.wrappedValue = Double(newValue)
                    }
                }
            )
        )
        .keyboardType(.decimalPad)
        .frame(width: 50)
        .multilineTextAlignment(.center)
    }
    
    private func intField(
        value: Binding<Int?>,
        placeholder: String
    ) -> some View {
        TextField(
            placeholder,
            text: Binding(
                get: {
                    guard let value = value.wrappedValue else { return "" }
                    return value == 0 ? "" : String(value)
                },
                set: { newValue in
                    if newValue.isEmpty {
                        value.wrappedValue = nil
                    } else {
                        value.wrappedValue = Int(newValue)
                    }
                }
            )
        )
        .keyboardType(.numberPad)
        .frame(width: 50)
        .multilineTextAlignment(.center)
    }
}

#Preview {
    VStack{
        Spacer()
        TrackedExerciseView(trackedExercise: .constant(TrackedExercise(id: "", workoutId: "", exercise: MockData.exercises[0], restTime: 90, sets: MockData.sets)), onExerciseRemove: {_ in}) { _ in} onDone: { _ in }
        Spacer()
    }.background(Color.custom.background)
        .preferredColorScheme(.dark)
}



