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
        
        Text("Describe")
            .fontWeight(.bold)
        
        HStack{
            VStack(alignment: .leading){
                Text("Time")
            }
            
            VStack(alignment: .leading) {
                Text("Volume")
            }
            
            VStack(alignment:.leading) {
                Text("Records")
            }
        }
    }
}
#Preview {
    HomeView(viewModel: HomeViewModel())
        .preferredColorScheme(.dark)
}
