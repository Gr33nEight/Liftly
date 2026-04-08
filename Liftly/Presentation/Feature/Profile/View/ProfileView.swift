//
//  ProfileView.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    var body: some View {
        Text("Profile View")
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel())
}
