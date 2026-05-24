//
//  RegisterView.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        ZStack{
            Color.custom.background
                .ignoresSafeArea()
            
            VStack{
                Text("Sign in")
                
                CustomTextField(text: $email, placeholder: "Enter your email")
                
                CustomTextField(text: $password, placeholder: "Passwor", isPassword: true)
                
                CustomTextField(text: $password, placeholder: "Enter your password again", isPassword: true)
                
                Button(action: {}) {
                    Text("Sign in")
                }
                .padding()
                .background(Color.custom.secondary)
                .cornerRadius(10)
            }
            .padding(.horizontal, 20)
        }
        .foregroundColor(Color.custom.text)
    }
}

#Preview {
    RegisterView()
}
