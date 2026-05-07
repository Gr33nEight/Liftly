//
//  SimpleExcerciseRow.swift
//  Liftly
//
//  Created by Natanael Jop on 07/05/2026.
//
import Kingfisher
import SwiftUI

struct SimpleExcerciseRow: View {

    var exercise: Exercise
    
    var body: some View {
        HStack(spacing: 20){
            ZStack {
                Color.custom.tertiary.opacity(0.5)

                if let url = exercise.imageUrl {
                    KFImage(url)
                        .setProcessor(DownsamplingImageProcessor(size: CGSize(width: 60, height: 60)))
                        .cacheOriginalImage()
                        .resizable()
                        .scaledToFill()
                } else {
                    Image("icon")
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            
            Text(exercise.title)
                .font(.custom.body())
                .foregroundColor(Color.custom.text)
            
            Spacer()
        }
    }
}
