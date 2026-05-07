//
//  TrackedExerciseView.swift
//  Liftly
//
//  Created by Natanael Jop on 09/04/2026.
//


import SwiftUI
import SwipeCell
import Kingfisher

struct TrackedExerciseView: View {
    var isRoutineView: Bool = false
    @Binding var trackedExercise: TrackedExerciseEntry
    @State private var showTimerModal: Bool = false
    
    var onExerciseRemove: (String) -> Void
    var onSetRemove: (String, String) -> Void
    var onExerciseReplace: (String) -> Void
    var onDone: (Int) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            header
            restTimer
            setList
        }
        .sheet(isPresented: $showTimerModal) {
            TimerView(trackedExercise: $trackedExercise)
                .presentationDetents([.fraction(0.5)])
        }

    }
}

// Components
extension TrackedExerciseView {
    private var header: some View {
        HStack(spacing: 15) {
            ZStack {
                Color.custom.tertiary.opacity(0.5)
                KFImage(trackedExercise.exercise.imageUrl)
                    .resizable()
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
    }
    private var restTimer: some View {
        Button {
            showTimerModal.toggle()
        } label: {
            Label("Rest Timer: \(trackedExercise.restTime.formatIntoTime())", systemImage: "timer")
        }
        .font(.custom.body())
        .foregroundStyle(Color.custom.secondary)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private var setList: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            Text("SET")
            
            if trackedExercise.hasWeight { Text("KG") }
            if trackedExercise.hasReps { Text("REPS") }
            if trackedExercise.hasDistance { Text("DIST") }
            if trackedExercise.hasDuration { Text("TIME") }
            
            if !isRoutineView {
                Image(systemName: "checkmark").font(.title3).bold()
            }
        }.padding(.horizontal)
        .foregroundStyle(Color.custom.tertiary)
        .font(.custom.subheadline())
        
        VStack(spacing: 4) {
            ForEach($trackedExercise.sets) { $set in
                LazyVGrid(columns: columns, spacing: 12) {
                    
                    Text(set.type.displayedValue).bold()
                        .foregroundStyle(Color.custom.text)
                    

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

                    
                    if !isRoutineView {
                        Button {
                            set.isDone.toggle()
                            if set.isDone {
                                onDone(trackedExercise.restTime)
                            }
                        } label: {
                            Image(systemName: set.isDone ? "checkmark.square.fill" : "square")
                                .foregroundStyle(
                                    set.isDone ? Color.custom.text : Color.custom.tertiary
                                )
                                .font(.title)
                        }
                    }
                }.padding()
                .background(
                    set.isDone ? Color.custom.green.opacity(0.75) : Color.custom.tertiary.opacity(0.1)
                )
//                .swipeCell(
//                    cellPosition: .right,
//                    leftSlot: nil,
//                    rightSlot: SwipeCellSlot(
//                        slots: [
//                            SwipeCellButton(
//                                buttonStyle: .title,
//                                title: "Delete",
//                                systemImage: nil,
//                                titleColor: Color.custom.text,
//                                imageColor: Color.custom.text,
//                                view: nil,
//                                backgroundColor: Color.red,
//                                action: {
//                                    onSetRemove(set.id, trackedExercise.id)
//                                },
//                                feedback: true
//                            )
//                        ],
//                        slotStyle: .destructive,
//                        buttonWidth: 100,
//                        appearAnimation: .easeIn,
//                        dismissAnimation: .easeOut,
//                        showAction: nil
//                    ),
//                    swipeCellStyle: .defaultStyle(),
//                    clip: true,
//                    disable: false,
//                    initalStatus: .showCell,
//                    initialStatusResetDelay: 0
//                )
                .frame(height: 55)
            }.font(.custom.metricSmall())
        }
        
        Button("+ Add Set") {
            addSet()
        }
        .customButtonStyle(.secondary)
        .padding([.top, .horizontal])
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
        
        if !isRoutineView {
            cols.append(GridItem(.fixed(40)))
        }
        
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


// functions
extension TrackedExerciseView {
    private func addSet() {
        let newSet = ExerciseSet.create(
            type: .normal(trackedExercise.sets.count + 1),
            exerciseType: trackedExercise.exercise.exerciseType
        )
        trackedExercise.sets.append(newSet)
    }
}

#Preview {
    VStack{
        Spacer()
        TrackedExerciseView(trackedExercise: .constant(TrackedExerciseEntry(id: "", workoutId: "", exercise: MockData.exercises[0], restTime: 90, sets: MockData.sets)), onExerciseRemove: {_ in},  onSetRemove: { _, _ in}, onExerciseReplace: {_ in}, onDone: {_ in})
        Spacer()
    }.background(Color.custom.background)
        .preferredColorScheme(.dark)
}



