//
//  RoutineCellView.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//
import SwiftUI

struct RoutineCellView: View {
    let routine: Routine
    var body: some View {
        Button {
            
        } label: {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(routine.title)
                        .font(.custom.title3())
                        .foregroundStyle(Color.custom.text)
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
                Text("\(routine.exerciseTitles.joined(separator: ", "))")
                    .foregroundStyle(Color.custom.tertiary)
                    .font(.custom.footnote())
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Button("Start Routine") {
                    
                }.customButtonStyle(.primary)
                    .padding(.top, 5)
            }.customBackground()
        }.padding(1)
    }
}
