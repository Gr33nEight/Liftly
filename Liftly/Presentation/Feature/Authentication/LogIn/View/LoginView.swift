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
    private static var correctEmail: String = "Test@gmail.com"
    private static var correctPassword: String = "Test1234"
    @State private var showError: Bool = false
    var body: some View {
        ZStack{
            Color.custom.background
                .ignoresSafeArea()
            
            VStack(spacing: 0){
                Spacer()
                
                Text("Welcome in Liftly")
                    .font(.custom.largeTitle())
                
                Text("Login your acount with")
                    .font(.custom.title3())
                
                Text("Email and Password")
                    .font(.custom.title3())
                Spacer()
                    
                
                Divider()
                    .background(Color.custom.tertiary)
                
                VStack(alignment: .leading, spacing: 5){
                    CustomTextField(text: $email, iconName: "envelope", placeholder: "Email")
                    
                    if showError, let error = validateEmail().errorMessage {
                        Text(error)
                            .foregroundStyle(Color.red)
                    }
                }
                .padding(.vertical, 30)
                
                VStack(alignment: .leading, spacing: 5){
                    CustomTextField(text: $password, iconName: "lock", placeholder: "Password", isPassword: true)
                    
                    if showError, let error = validPassword().errorMessage {
                        Text(error)
                            .foregroundStyle(Color.red)
                    }
                }
                
                Spacer()
                
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
        if email.range(of: emailPattern, options: .regularExpression) == nil && email != LoginView.correctEmail {
            return.failure("Enter a correct Email addres")
        }
        return .success
    }
    
    func validPassword() -> ValidationResult {
        if password.count < 8 && password != LoginView.correctPassword {
            return .failure("Enter correct Password")
        }
        return .success
    }
}

#Preview{
    LoginView()
}
