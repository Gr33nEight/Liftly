//
//  ContentView.swift
//  Liftly
//
//  Created by Natanael Jop on 01/04/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Hello world!")
                .foregroundStyle(Color.custom.primary)
                .font(.largeTitle)
            Spacer()
        }.frame(maxWidth: .infinity)
            .background(Color.custom.background)
    }
}

#Preview {
    ContentView()
}
