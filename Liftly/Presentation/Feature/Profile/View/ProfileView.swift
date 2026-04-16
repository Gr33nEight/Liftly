//
//  ProfileView.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import SwiftUI
import PhotosUI

enum StatsTimeOptions: String, CaseIterable {
    case week = "Week"
    case month = "Month"
    case year = "Year"
    case allTime
}

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    @State var selectedStatsOccurence: String?
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var imageData: Data?
    @State private var image: UIImage?
    
    @State private var pickedStatsTime: StatsTimeOptions = .week
    
    var body: some View {
        VStack(spacing: 0) {
            header
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    profile
                    stats
                    workouts
                }
                .padding()
            }.frame(maxWidth: .infinity)
                .background(Color.custom.background)
        }
    }
}

extension ProfileView {
    private var header: some View {
        HStack {
            Text("GreenEight")
                .foregroundStyle(Color.custom.text)
                .font(.custom.title())
            Spacer()
            HStack(spacing: 18) {
                Button {
                    
                } label: {
                    Image(systemName: "square.and.pencil")
                }
                Button {
                    
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
                Button {
                    
                } label: {
                    Image(systemName: "gearshape")
                }
            }.font(.custom.bodyBold())
        }
        
        .padding(.horizontal)
        .padding(.bottom, 10)
        .background(Color.custom.darkerBackground)
    }
    
    private var profile: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 10) {
                profileImageView
                VStack(alignment: .leading) {
                    HStack {
                        StatCell(title: "Workouts", value: "282", alignment: .leading)
                        Spacer()
                        StatCell(title: "Followers", value: "25", alignment: .leading)
                        Spacer()
                        StatCell(title: "Following", value: "25", alignment: .leading)
                    }
                }
            }
            Text(
            """
            🏋️‍♀️ Gym 5x / tyg
            ⏰ 7:00 AM
            🔁 Upper / Lower split
            ⚖️ 69 kg → 🎯 75 kg
            """
            ).foregroundStyle(Color.custom.text)
                .font(.custom.body())
            
        }
    }
    
    private var profileImageView: some View {
        HStack {
            let image = self.image
            PhotosPicker(selection: $selectedItem, matching: .images) {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 100)
                }else{
                    ZStack {
                        Circle()
                            .fill(Color.custom.darkerBackground)
                        Image(systemName: "person.badge.plus")
                            .font(.custom.title())
                            .foregroundStyle(Color.custom.secondary)
                    }
                }
            }
        }.frame(height: 100)
            .onChange(of: selectedItem) { _, newItem in
                Task {
                    await loadImage(from: newItem)
                }
            }
    }
    
    private var stats: some View {
        VStack(spacing: 30) {
            HStack(alignment: .center) {
                if let selectedStatsOccurence {
                    Text("\(selectedStatData(selectedStatsOccurence)) hours")
                        .foregroundStyle(Color.custom.text)
                        .font(.custom.title2())
                    Text("\(selectedStatsOccurence)")
                        .foregroundStyle(Color.custom.tertiary)
                        .font(.custom.bodyLight())
                }else{
                    Text("\(MockData.stats.map({$0.data}).reduce(0, +)) hours")
                        .foregroundStyle(Color.custom.text)
                        .font(.custom.title2())
                    Text("last \(pickedStatsTime.rawValue.lowercased())")
                        .foregroundStyle(Color.custom.tertiary)
                        .font(.custom.bodyLight())
                }
                Spacer()
                Menu {
                    ForEach(StatsTimeOptions.allCases, id: \.rawValue) { option in
                        Button {
                            pickedStatsTime = option
                        } label: {
                            Text(option.rawValue)
                                .foregroundStyle(Color.custom.text)
                        }

                    }
                } label: {
                    Text("Last \(pickedStatsTime.rawValue)")
                        .foregroundStyle(Color.custom.primary)
                }
                .font(.custom.body())

            }
            ChartsView(selected: $selectedStatsOccurence)
        }
    }
    
    private func selectedStatData(_ occurence: String) -> Int {
        MockData.stats.first(where: {$0.occurence == occurence})?.data ?? 0
    }
    
    private var workouts: some View {
        VStack(alignment: .leading) {
            Text("Workouts")
                .foregroundStyle(Color.custom.tertiary)
                .font(.custom.bodyLight())
            LazyVStack {
                ForEach(MockData.posts, id: \.id) { post in
                    PostCell(post: post)
                }
            }
        }
    }
}

extension ProfileView {
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
    ProfileView(viewModel: ProfileViewModel())
        .preferredColorScheme(.dark)
}

