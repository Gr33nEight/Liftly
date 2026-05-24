//
//  LogInView.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import SwiftUI

struct LogInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        ZStack{
            Color.custom.background
                .ignoresSafeArea()
            
            VStack{
                Text("Login")
                
                CustomTextField(text: $email, placeholder: "Email")
                
                CustomTextField(text: $password, placeholder: "Password", isPassword: true)
                
                NavigationLink(destination: RegisterView()) {
                    Text("Sign in")
                }
                
                Button(action: {}) {
                    Text("Login")
                }
                .padding()
                .background(Color.custom.secondary)
                .cornerRadius(10)
            }
            .padding(.horizontal,20)
            
        }
        .foregroundColor(Color.custom.text)
    }
}

#Preview {
    LogInView()
}
