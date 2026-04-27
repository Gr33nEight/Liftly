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
        VStack(spacing: 5){
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
            }.padding(.horizontal)
            
            ScrollView{
                ForEach (MockData.routines, id: \.title){ Rutine in
                    PostCell(routine: Rutine)
                }
            }
        }
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
