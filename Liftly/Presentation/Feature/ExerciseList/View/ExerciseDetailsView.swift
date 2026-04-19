//
//  ExerciseDetailsView.swift
//  Liftly
//
//  Created by Natanael Jop on 15/04/2026.
//

import SwiftUI
import Kingfisher

struct ExerciseDetailsView: View {
    @Environment(\.dismiss) var dismiss
    let exercise: Exercise
    var body: some View {
        VStack {
            header
            ScrollView {
                VStack {
                    ZStack {
                        if let videoUrl = exercise.videoUrl {
                            LoopingVideoView(url: videoUrl)
                                .scaledToFit()
                                
                        } else if let imageUrl = exercise.imageUrl {
                            KFImage(imageUrl)
                                .resizable()
                                .scaledToFit()
                        }
                    }.frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        
                    VStack(alignment: .leading, spacing: 20) {
                        Text(exercise.title)
                            .font(.custom.title())
                            .foregroundStyle(Color.custom.primary)
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Equipment: \(exercise.equipment.displayName)")
                            Text("Primary: \(exercise.primaryMuscleGroup.displayName)")
                            Text("Secondary: \(exercise.otherMuscleGroup.displayName)")
                        }
                            .font(.custom.bodyLight())
                            .foregroundStyle(Color.custom.tertiary)
                        Text(exercise.howTo)
                            .font(.custom.body())
                            .foregroundStyle(Color.custom.text)
                    }.padding()
                }
            }
            
        }.background(Color.custom.background)
    }
}


extension ExerciseDetailsView {
    private var header: some View {
        ZStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                Spacer()
            }
            Text(exercise.title)
                .font(.custom.bodyMedium())
                .foregroundStyle(Color.custom.text)
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
        .background(Color.custom.darkerBackground)
        .navigationBarBackButtonHidden()
}
}


#Preview {
    ExerciseDetailsView(exercise: MockData.exercises[0])
}

