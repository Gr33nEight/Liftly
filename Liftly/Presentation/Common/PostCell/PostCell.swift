//
//  PostCell.swift
//  Liftly
//
//  Created by Krzysztof Stępień on 26/04/2026.
//

import SwiftUI

struct PostCell: View {
    var post: PostDetails
    
    @State private var isLiked: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            postCellProfileInfo
            
            //statistics
            Text(routine.title)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.bottom, 10)
                .padding(.top, -10)
            
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
                
            }.padding(.horizontal)
            
            Divider()
            
            if let photoName = routine.workoutPhoto {
                TabView{
                    Image(photoName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 300)
                        .clipped()
                        .cornerRadius(12)
                    
                    exercisesSummarySlide
                }
                .frame(height: 320)
                .tabViewStyle(.page(indexDisplayMode: .always))
            } else {
                exercisesSummarySlide
            }
            
            HStack{
                Button (action: {
                    isLiked.toggle()
                }) {
                    Image(systemName: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .scaleEffect(isLiked ? 1.2 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isLiked)
                }
                
                Button (action: {}) {
                    Image(systemName: "message")
                }.padding(.horizontal)
                
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height:10)
                .padding(.vertical, 20)
        }
    }
    
    private var postCellProfileInfo: some View{
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
    }
    
    private var exercisesSummarySlide: some View {
        VStack (spacing: 10){
            ForEach(routine.exercises.prefix(3), id: \.title) { exercise in
                SimpleExcerciseRow(iconName: "figure.strengthtraining.traditional", exerciseText: exercise.title)
            }
            
            if routine.exercises.count > 3 {
                let hiddenCount = routine.exercises.count - 3
                
                Text("See \(hiddenCount) more exercise")
                    .font(.subheadline)
                    .foregroundColor(.custom.tertiary)
            }
        }
        .padding(.horizontal)
        .padding(.top, 4)
    }
}
