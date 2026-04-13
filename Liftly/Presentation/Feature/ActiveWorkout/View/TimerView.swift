//
//  TimerView.swift
//  Liftly
//
//  Created by Natanael Jop on 10/04/2026.
//

import SwiftUI

struct TimerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var trackedExercise: TrackedExercise
    let numbers = Array(stride(from: 0, through: 300, by: 5))
    var body: some View {
        VStack(spacing: 8) {
            Text("Rest Timer")
                .foregroundStyle(Color.custom.text)
                .font(Font.custom.bodyMedium())
            Text(trackedExercise.exercise.title)
                .foregroundStyle(Color.custom.secondary)
                .font(Font.custom.subheadline())
            Picker(selection: $trackedExercise.restTime) {
                ForEach(numbers, id:\.self) { num in
                    ZStack {
                        if num == 0 {
                            Text("off")
                        }else{
                            Text(num.formatIntoTime())
                        }
                    }.foregroundStyle(Color.custom.primary)
                        .font(.custom.title2())
                }
            } label: {}.pickerStyle(.wheel)
            Button("Done") {
                dismiss()
            }
                .customButtonStyle(.primary)
        }.padding(.horizontal)
        .frame(maxHeight: .infinity)
        .background(Color.custom.background)

    }
}

#Preview {
    TimerView(trackedExercise: .constant(TrackedExercise(id: "", workoutId: "", exercise: MockData.exercises[0], restTime: 90, sets: []))).preferredColorScheme(.dark)
}
