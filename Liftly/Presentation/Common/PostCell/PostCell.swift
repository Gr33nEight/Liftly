//
//  PostCell.swift
//  Liftly
//
//  Created by Krzysztof Stępień on 26/04/2026.
//

import SwiftUI

struct PostCell: View {
    var routine: RoutineEntry
    
    var body: some View {
        VStack(alignment: .leading) {
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
            Text(routine.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
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
            }.padding(.horizontal)
            
            VStack (spacing: 10){
                ForEach(routine.exercises, id: \.title) { exercise in
                    SimpleExcerciseRow(iconName: "figure.strengthtraining.traditional", exerciseText: exercise.title)
                }
            }.padding()
            
            Divider()
                .background(Color.custom.background)
                .padding(.vertical, 20)
        }
    }
}

