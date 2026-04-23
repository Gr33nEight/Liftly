//
//  HomeView.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    var body: some View {
        VStack {
            HStack {
                Text("Home")
                    .font(.custom.largeTitle())
                Spacer()
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                }
            
                Button(action: {}) {
                    Image(systemName: "bell")
                }
            }.padding(20)
            
            ScrollView{
                ForEach (1..<2, id: \.self){ _ in
                    PostCell()
                    
                    PostCell()
                    
                    PostCell()
                    
                    PostCell()
                }
            }
        }
    }
}
// Posts
struct PostCell: View {
    var body: some View {
        HStack {
            //profil photo
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .padding(10)
                .frame(width:50, height: 50)
                .background(Color.gray.opacity(0.3))
                .clipShape(Circle())
            
            //describe profile
            VStack(alignment: .leading) {
                Text("User123")
                    .font(.headline)
                
                Text("3 ours ago")
                    .font(.subheadline)
                    .foregroundColor(.custom.tertiary)
            }
            
            Spacer()
            
        } .padding()
        
        //statistics
        Text("Describe")
            .fontWeight(.bold)
        
        HStack (spacing: 25){
            VStack(alignment: .leading){
                Text("Time")
                    .font(.caption)
                    .foregroundColor(.custom.tertiary)
                Text("1h 30min")
                    .font(.headline)
            }
            
            VStack(alignment: .leading) {
                Text("Volume")
                    .font(.caption)
                    .foregroundColor(.custom.tertiary)
                Text("3500kg")
                    .font(.headline)
            }
            
            VStack(alignment:.leading) {
                Text("Records")
                    .font(.caption)
                    .foregroundColor(.custom.tertiary)
                
                HStack(spacing: 4) {
                    Image(systemName: "medal.fill")
                        .foregroundColor(.yellow)
                    Text("4")
                }
            }
            
            VStack{
                Text("Acg Bpm")
                    .font(.caption)
                    .foregroundColor(.custom.tertiary)
                HStack(spacing: 4) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text("117")
                }
            }
        }
        
        VStack (spacing: 10){
            SimpleExcerciseRow(iconName: "figure.strengthtraining.traditional", exerciseText: "4 sets Bench Press")
            
            SimpleExcerciseRow(iconName: "figure.walk", exerciseText: "4 stets Lunge")
            
            SimpleExcerciseRow(iconName: "figure.strengthtraining.traditional", exerciseText: "4 Gorllla Row")
        }.padding()
    }
}

//Template exercise
struct SimpleExcerciseRow: View {
    var iconName: String
    var exerciseText: String
    
    var body: some View {
        HStack{
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .padding(10)
                .frame(width: 50, height: 50)
                .background(Color.white)
                .foregroundColor(.black)
                .clipShape(Circle())
            
            Text(exerciseText)
                .font(.custom.body())
                .foregroundColor(.white)
            
            Spacer()
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(currentUserId: "", deletePostUseCase: MockDeletePostUseCase(), fetchPostsUseCase: MockFetchPostsUseCase(), toggleLikeUseCase: MockToggleLikeUseCase()))
        .preferredColorScheme(.dark)
}
