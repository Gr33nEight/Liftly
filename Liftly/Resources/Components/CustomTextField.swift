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
    @FocusState var isTaping: Bool
    
    var iconName: String? = nil
    
    var placeholder: String
    var isPassword: Bool = false
    
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        HStack {
            
            if let icon = iconName {
                Image(systemName: icon)
                    .foregroundColor(.custom.tertiary)
                    .frame(width: 20)
            }
            
            ZStack (alignment: .leading){
                if isPassword {
                    if isPasswordVisible {
                        TextField("", text: $text)
                    } else {
                        SecureField("", text: $text)
                    }
                } else {
                    TextField("", text: $text)
                }
                
                Text(placeholder)
                    .padding(.horizontal, 5)
                    .background(Color.custom.background.opacity(isTaping || !text.isEmpty ? 1 : 0))
                    .foregroundStyle(isTaping ? .custom.primary : Color.custom.text)
                    .offset(y: isTaping || !text.isEmpty ? -27 : 0)
                    .onTapGesture {
                        isTaping.toggle()
                    }


            }
            
            if isPassword {
                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                }

            }
        }
        .padding()
        .frame(height: 55)
        .focused($isTaping)
        .background(isTaping ? .custom.primary : Color.custom.text,in: RoundedRectangle(cornerRadius: 14).stroke(lineWidth: 2))
        .animation(.linear(duration: 0.2), value: isTaping)
        
    }
}
