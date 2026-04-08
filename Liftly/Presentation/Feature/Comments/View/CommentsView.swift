//
//  CommentsView.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import SwiftUI

struct CommentsView: View {
    @StateObject var viewModel: CommentsViewModel
    var body: some View {
        Text("Comments View")
    }
}

#Preview {
    CommentsView(viewModel: CommentsViewModel())
}
