//
//  PostCell.swift
//  Liftly
//
//  Created by Krzysztof Stępień on 26/04/2026.
//

import SwiftUI
import Kingfisher

struct PostCell: View {
    var post: PostDetails
    
    @State private var isLiked: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            VStack(spacing: 20) {
                postCellProfileInfo
                
                //statistics
                Text(post.title)
                    .font(.custom.title3())
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 20) {
                    StatCell(title: "Time", value: post.workout.duration.formatIntoTime(), alignment: .leading, ommitSpacer: true, ommitSecondSpacer: true, color: Color.custom.text)
                    StatCell(title: "Volume", value: "\(post.workout.volume.formatted())kg", alignment: .leading, ommitSpacer: true, color: Color.custom.text)
                }
            }.padding(.horizontal)
            
            if let img = post.image {
                TabView{
                    KFImage(img)
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fill)
                    exercisesSummarySlide(5)
                }
                .frame(height: UIScreen.main.bounds.width)
                .tabViewStyle(.page(indexDisplayMode: .always))
            } else {
                Divider()
                exercisesSummarySlide(3)
                Divider()
            }
            
            HStack(spacing: 20) {
                Button (action: {
                    isLiked.toggle()
                }) {
                    Image(systemName: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .scaleEffect(isLiked ? 1.2 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isLiked)
                }
                
                Button (action: {}) {
                    Image(systemName: "message")
                }
                
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.up")
                }
            }.foregroundStyle(Color.custom.text)
                .padding(.horizontal)
        }
    }
    
    private var postCellProfileInfo: some View{
        HStack {
            
            ZStack {
                if let image = post.owner.image {
                    KFImage(image)
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .clipShape(Circle())
                        
                }else{
                    ZStack {
                        Circle()
                            .fill(Color.custom.darkerBackground)
                        Image(systemName: "person")
                            .font(.custom.title())
                            .foregroundStyle(Color.custom.secondary)
                    }
                }
            }.frame(width: 60)
            
            //describe profile
            VStack(alignment: .leading) {
                Text(post.owner.name)
                    .font(.headline)
                
                Text(post.dateCreated.timeAgoDisplay())
                    .font(.subheadline)
                    .foregroundColor(.custom.tertiary)
            }
            
            Spacer()
            
        }
    }
    
    private func exercisesSummarySlide(_ numberOfExercises: Int) -> some View {
        VStack (spacing: 10){
            ForEach(post.exercises.prefix(numberOfExercises), id: \.title) { exercise in
                SimpleExcerciseRow(exercise: exercise)
            }
            
            if post.exercises.count > numberOfExercises {
                let hiddenCount = post.exercises.count - numberOfExercises
                
                Text("See \(hiddenCount) more exercise")
                    .font(.subheadline)
                    .foregroundColor(.custom.tertiary)
            }
        }.padding(.horizontal)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(currentUserId: "", deletePostUseCase: MockDeletePostUseCase(), fetchPostsUseCase: MockFetchPostsUseCase(), toggleLikeUseCase: MockToggleLikeUseCase(), getUserUseCase: MockGetUserUseCase()))
        .preferredColorScheme(.dark)
}
