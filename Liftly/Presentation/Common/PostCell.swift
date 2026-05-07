//
//  PostCell.swift
//  Liftly
//
//  Created by Natanael Jop on 16/04/2026.
//

import SwiftUI

struct PostCell: View {
    let post: PostDetails
    var body: some View {
        Text("Title: \(post.title)")
    }
}

#Preview {
    PostCell(post: MockData.posts[0])
}
