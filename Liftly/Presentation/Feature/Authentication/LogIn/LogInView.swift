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
                Text("Welcome in Liftly")
                    .padding(.top, 160)
                    .font(.largeTitle)
                
                Text("Login your acount with")
                    .font(.title3)
                    .padding(.top, -13)
                Text("Email and Password")
                    .padding(.bottom, 40)
                    .font(.title3)
                    
                
                Divider()
                    .background(Color.custom.tertiary)
                
                CustomTextField(text: $email, iconName: "envelope", placeholder: "Email")
                    .padding(.vertical, 30)
                
                CustomTextField(text: $password, iconName: "lock", placeholder: "Password", isPassword: true)
                    .padding(.bottom, 30)
                
                Button(action: {}) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.custom.secondary)
                .cornerRadius(10)
                
                Spacer()
                
                NavigationLink(destination: RegisterView()) {
                    Text("Sign in")
                        .font(.title2)
                }
                .padding(.vertical, 30)
            }
            .padding(.horizontal,20)
            
        }
        .foregroundColor(Color.custom.text)
    }
}

#Preview {
    LogInView()
}
