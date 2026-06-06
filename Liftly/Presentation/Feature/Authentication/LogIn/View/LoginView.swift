//
//  LogInView.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import SwiftUI

enum ValidationResult {
    case success
    case failure(String)
    
    var errorMessage: String? {
        switch self {
        case .success: return nil
        case .failure(let msg): return msg
        }
    }
}

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var correctEmai: String = "Test@gmail.com"
    @State private var correctPassword: String = "Test1234"
    @State private var showError: Bool = false
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
                if showError, let error = validateEmail().errorMessage {
                    Text(error)
                        .foregroundStyle(Color.red)
                        .padding(.top, -35)
                }
                
                CustomTextField(text: $password, iconName: "lock", placeholder: "Password", isPassword: true)
                    .padding(.bottom, 30)
                if showError, let error = validPassword().errorMessage {
                    Text(error)
                        .foregroundStyle(Color.red)
                        .padding(.top, -35)
                }
                
                Button(action: {
                    if isFormValid{
                        print("Login success")
                    } else {
                        showError = true
                    }
                }) {
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
    
    var isFormValid: Bool {
        [
            validateEmail(),
            validPassword(),
        ].allSatisfy {
            if case .success = $0 { return true }
            else{
                return false
            }
        }
    }
    
    func validateEmail() -> ValidationResult {
        let emailPattern = #"^\S+@\S+\.\S+$"#
        if email.range(of: emailPattern, options: .regularExpression) == nil && email != correctEmai {
            return.failure("Enter a correct Email addres")
        }
        return .success
    }
    
    func validPassword() -> ValidationResult {
        if password.count < 8 && password != correctPassword {
            return .failure("Enter correct Password")
        }
        return .success
    }
}

#Preview{
    LoginView()
}
