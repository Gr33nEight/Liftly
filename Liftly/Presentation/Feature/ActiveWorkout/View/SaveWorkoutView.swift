//
//  SaveWorkoutView.swift
//  Liftly
//
//  Created by Natanael Jop on 10/04/2026.
//

import SwiftUI

struct SaveWorkoutView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ActiveWorkoutViewModel
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var isPublic: Bool = true
    @State private var date: Date = Date()
    @State private var showDatePicker: Bool = false
    
    var onSave: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    Spacer()
                    Button("Save") {
                        Task {
                            await viewModel.savePost(
                                title: title,
                                description: description,
                                date: date,
                                isPublic: isPublic
                            )
                            onSave()
                        }
                    }
                    .frame(width: 60)
                    .customButtonStyle(.primary)
                }
                Text("Save Workout")
                    .foregroundStyle(Color.custom.text)
                    .font(.custom.bodyMedium())
            }.padding(.horizontal)
                .padding(.bottom, 10)
            .background(Color.custom.darkerBackground)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    HStack {
                        TextField("Workout title", text: $title)
                            .font(.custom.largeTitle())
                        Button {
                            
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.custom.title3())
                                .foregroundStyle(Color.custom.secondary)
                        }

                    }
                    Divider()
                    HStack {
                        statCell("Duration", "\(viewModel.duration.format())")
                        statCell("Volume", "\(viewModel.totalVolume)kg")
                        statCell("Sets", "\(viewModel.totalSets)")
                    }
                    Divider()
                    Button(action: {
                        showDatePicker.toggle()
                    }) {
                        statCell("When", date.formatted(date: .abbreviated, time: .shortened))
                    }
                    Divider()
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "photo.badge.plus")
                                .padding(50)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.custom.secondary, style: StrokeStyle(
                                            lineWidth: 2,
                                            dash: [7]
                                        ))
                                ).padding(1)
                        }
                        Text("Add a photo / video")
                            .font(.custom.body())
                            .foregroundStyle(Color.custom.tertiary)
                            .padding(.horizontal)
                        Spacer()
                    
                    }
                    Divider()
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description")
                            .font(.custom.footnote())
                            .foregroundStyle(Color.custom.tertiary)
                        TextField("How did your workout go? Leave some notes here...", text: $description, axis: .vertical)
                            .lineLimit(2...)
                            .font(.custom.bodyLight())
                    }
                    Divider()
                    Toggle(isOn: $isPublic) {
                        Text("Is this workout public?")
                            .font(.custom.body())
                            .foregroundStyle(Color.custom.tertiary)
                    }.tint(Color.custom.secondary)
                        .padding(.trailing, 5)
                }.padding()
            }
        }
            .background(Color.custom.background)
            .sheet(isPresented: $showDatePicker) {
                VStack {
                    DatePicker(
                        "Select date",
                        selection: $date,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    
                    Button("Done") {
                        showDatePicker = false
                    }.frame(width: 60)
                        .customButtonStyle(.primary)
                }
                .presentationDetents([.fraction(0.4)])
            }
    }
}

extension SaveWorkoutView {
    private func statCell(_ title: String, _ value: String) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
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
}

#Preview {
    SaveWorkoutView(viewModel: ActiveWorkoutViewModel(currentUserId: "", routineId: "", createPostUseCase: MockCreatePostUseCase(), getExercisesUseCase: MockGetExercisesUseCase())) { }
        .preferredColorScheme(.dark)
}
