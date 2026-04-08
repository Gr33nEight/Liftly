//
//  OtherProfileView.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import SwiftUI

struct OtherProfileView: View {
    @StateObject var viewModel: OtherProfileViewModel
    var body: some View {
        Text("Other Profile View")
    }
}

#Preview {
    OtherProfileView(viewModel: OtherProfileViewModel())
}
