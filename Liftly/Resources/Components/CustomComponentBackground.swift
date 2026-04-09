//
//  CustomComponentBackground.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import SwiftUI


struct CustomComponentBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(20)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.custom.background)
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.custom.secondary.opacity(0.5), lineWidth: 2)
                }
            )
    }
}

extension View {
    func customBackground() -> some View {
        self.modifier(CustomComponentBackground())
    }
}

#Preview {
    Text("Hello, world!")
        .modifier(CustomComponentBackground())
        .preferredColorScheme(.dark)
}
