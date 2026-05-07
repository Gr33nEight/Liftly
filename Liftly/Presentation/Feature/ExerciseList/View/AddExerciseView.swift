//
//  AddExerciseView.swift
//  Liftly
//
//  Created by Natanael Jop on 09/04/2026.
//

import SwiftUI
import Kingfisher

struct AddExerciseView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.navigate) var navigate
    
    @State private var selectedExercises: [Exercise] = []
    @State private var searchText: String = ""
    
    let type: ShowExerciseListType
    let exercises: [Exercise]
    var onDismiss: ([Exercise]) -> Void
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // HEADER
                ZStack {
                    HStack {
                        Button("Cancel") {
                            dismiss()
                        }
                        Spacer()
                    }
                    Text("Add Exercise")
                        .font(.custom.bodyMedium())
                        .foregroundStyle(Color.custom.text)
                }
                .padding()
                .background(Color.custom.darkerBackground)
                
                // SEARCH BAR
                searchBar
                    .padding(.horizontal)
                    .padding(.top, 8)
                
                // LIST
                ZStack(alignment: .bottom) {
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(filteredExercises, id: \.id) { exercise in
                                exerciseCell(for: exercise)
                                    .onTapGesture {
                                        switch type {
                                        case .add:
                                            toggle(exercise)
                                        case .replace(_):
                                            onDismiss([exercise])
                                            dismiss()
                                        }
                                    }
                            }
                        }
                        .padding(.top)
                    }
                    
                    // ADD BUTTON
                    if !selectedExercises.isEmpty {
                        Button("Add \(selectedExercises.count) Exercise\(selectedExercises.count == 1 ? "" : "s")") {
                            onDismiss(selectedExercises)
                            dismiss()
                        }
                        .customButtonStyle(.primary)
                        .padding(.bottom)
                    }
                }
                .padding(.horizontal)
            }
            .background(Color.custom.background)
            .onAppear {
                let urls = exercises
                    .prefix(30)
                    .compactMap { $0.imageUrl }
                
                ImagePrefetcher(urls: urls).start()
            }

        }
    }
}

extension AddExerciseView {
    
    // MARK: - CELL
    
    private func exerciseCell(for exercise: Exercise) -> some View {
        VStack(spacing: 15) {
            HStack(spacing: 10) {
                
                if isSelected(exercise) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.custom.primary)
                        .frame(width: 5)
                        .padding(2)
                }
                
                ZStack {
                    Color.custom.tertiary.opacity(0.5)

                    if let url = exercise.imageUrl {
                        KFImage(url)
                            .setProcessor(DownsamplingImageProcessor(size: CGSize(width: 60, height: 60)))
                            .cacheOriginalImage()
                            .resizable()
                            .scaledToFill()
                    } else {
                        Image("AppIcon")
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading) {
                    Text(exercise.title)
                        .font(.custom.bodyMedium())
                        .foregroundStyle(Color.custom.text)
                    
                    Text(
                        exercise.primaryMuscleGroup.displayName +
                        " | " + exercise.exerciseType.displayName +
                        " | " + exercise.equipment.displayName
                    )
                    .foregroundStyle(Color.custom.tertiary)
                    .font(.custom.subheadline())
                }
                
                Spacer()
                
                NavigationLink {
                    ExerciseDetailsView(exercise: exercise)
                } label: {
                    Image(systemName: "info.circle")
                        .font(.title)
                }

            }
            Divider()
        }
        .padding(.bottom, 5)
    }
    
    // MARK: - LOGIC
    
    private func toggle(_ exercise: Exercise) {
        withAnimation {
            if isSelected(exercise) {
                selectedExercises.removeAll { $0.id == exercise.id }
            } else {
                selectedExercises.append(exercise)
            }
        }
    }
    
    private func isSelected(_ exercise: Exercise) -> Bool {
        selectedExercises.contains { $0.id == exercise.id }
    }
    
    // MARK: - SEARCH
    
    private var filteredExercises: [Exercise] {
        let query = searchText.lowercased()
        let selectedIds = Set(selectedExercises.map { $0.id })
        
        return exercises
            .filter {
                query.isEmpty || $0.title.lowercased().contains(query)
            }
            .sorted { lhs, rhs in
                
                // 🔥 1. selected ALWAYS on top
                let lhsSelected = selectedIds.contains(lhs.id)
                let rhsSelected = selectedIds.contains(rhs.id)
                
                if lhsSelected != rhsSelected {
                    return lhsSelected
                }
                
                // 🔥 2. brak query → nie ruszaj kolejności
                guard !query.isEmpty else { return false }
                
                let lhsTitle = lhs.title.lowercased()
                let rhsTitle = rhs.title.lowercased()
                
                // 🔥 3. prefix match
                let lhsPrefix = lhsTitle.hasPrefix(query)
                let rhsPrefix = rhsTitle.hasPrefix(query)
                
                if lhsPrefix != rhsPrefix {
                    return lhsPrefix
                }
                
                // 🔥 4. shorter name
                return lhsTitle.count < rhsTitle.count
            }
    }
    
    // MARK: - SEARCH BAR
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.custom.tertiary)
            
            TextField("Search exercises", text: $searchText)
                .foregroundStyle(Color.custom.text)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.custom.tertiary)
                }
            }
        }
        .padding(10)
        .background(Color.custom.tertiary.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
