//
//  SaveWorkoutView.swift
//  Liftly
//
//  Created by Natanael Jop on 10/04/2026.
//

import SwiftUI
import PhotosUI

struct SaveWorkoutView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ActiveWorkoutViewModel
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var isPublic: Bool = true
    @State private var date: Date = Date()
    @State private var showDatePicker: Bool = false
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var imageData: Data?
    @State private var image: UIImage?
    
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
                                isPublic: isPublic,
                                image: imageData
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
                    titleTextField
                    HStack {
                        statCell("Duration", "\(viewModel.duration.formatIntoTime())")
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
                    addImageCell
                    descriptionCell
                    isPublicToggle
                }.padding()
            }
        }
            .background(Color.custom.background)
            .sheet(isPresented: $showDatePicker) {
                datePicker
            }
    }
}

// Components
extension SaveWorkoutView {
    @ViewBuilder
    private var titleTextField: some View {
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
    }
    
    @ViewBuilder
    private var addImageCell: some View {
            
            HStack {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: 120)
                        .overlay(alignment: .topTrailing) {
                            Button {
                                self.image = nil
                                imageData = nil
                                selectedItem = nil
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(Color.red)
                                    .font(.title)
                                    .background(
                                        Circle()
                                            .fill(Color.white)
                                            .padding(5)
                                    )
                            }
                            .offset(x: 15, y: -15)

                        }
                } else {
                    PhotosPicker(selection: $selectedItem, matching: .images) {
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
                }
                Spacer()
            }.frame(height: 120)
            
        .onChange(of: selectedItem) { _, newItem in
            Task {
                await loadImage(from: newItem)
            }
        }
        Divider()
    }
    
    @ViewBuilder
    private var descriptionCell: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Description")
                .font(.custom.footnote())
                .foregroundStyle(Color.custom.tertiary)
            TextField("How did your workout go? Leave some notes here...", text: $description, axis: .vertical)
                .lineLimit(2...)
                .font(.custom.bodyLight())
        }
        Divider()
    }
    
    private var isPublicToggle: some View {
        Toggle(isOn: $isPublic) {
            Text("Is this workout public?")
                .font(.custom.body())
                .foregroundStyle(Color.custom.tertiary)
        }.tint(Color.custom.secondary)
            .padding(.trailing, 5)
    }
    
    private var datePicker: some View {
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
    
    private func loadImage(from item: PhotosPickerItem?) async {
        guard let item else { return }
        
        do {
            if let data = try await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                
                let compressed = uiImage.jpegData(compressionQuality: 0.6)
                
                self.image = UIImage(data: compressed ?? data)
                self.imageData = compressed
            }
        } catch {
            print("Image load error:", error)
        }
    }
}

#Preview {
    SaveWorkoutView(viewModel: ActiveWorkoutViewModel(currentUserId: "", routineId: "", createPostUseCase: MockCreatePostUseCase(), getExercisesUseCase: MockGetExercisesUseCase(), getRoutineUseCase: MockGetRoutineUseCase()), onSave: {
        
    })
        .preferredColorScheme(.dark)
}
