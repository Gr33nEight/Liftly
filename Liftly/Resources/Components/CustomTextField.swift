//
//  CustomTextField.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import Foundation
import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    
    var placeholder: String
    var isPassword: Bool = false
    
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        HStack {
            if isPassword {
                if isPasswordVisible {
                    TextField(placeholder, text: $text)
                } else {
                    SecureField(placeholder, text: $text)
                }
                
                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                }
                
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .padding()
        .background(Color.custom.tertiary)
        .cornerRadius(10)
    }
}
