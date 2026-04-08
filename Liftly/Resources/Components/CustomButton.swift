//
//  CustomButton.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import SwiftUI

struct PrimaryButton: ButtonStyle {
    var color: Color = Color.custom.primary
    var textColor: Color = Color.custom.text
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).fill(color))
            .foregroundColor(textColor)
            .font(.custom.bodyMedium())
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct SecondaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10).stroke(Color.custom.text, lineWidth: 1)
                    RoundedRectangle(cornerRadius: 10).fill(Color.custom.background)
                }
            )
            .foregroundColor(.custom.text)
            .font(.custom.bodyMedium())
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct DisabledButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.custom.tertiary))
            .foregroundColor(.custom.background)
            .font(.custom.bodyMedium())
    }
}

enum ButtonStyles {
    case primary, secondary, disabled
}

extension View {
    @ViewBuilder
    func customButtonStyle(_ style: ButtonStyles, color: Color = Color.custom.primary, textColor: Color = Color.custom.text) -> some View {
        switch style {
        case .primary: buttonStyle(PrimaryButton(color: color, textColor: textColor))
        case .secondary: buttonStyle(SecondaryButton())
        case .disabled: buttonStyle(DisabledButton())
        }
    }
}
