//
//  RegisterView.swift
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

struct RegisterView: View {
    @State private var fName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showError: Bool = false

    var body: some View {
        ZStack{
            Color.custom.background
                .ignoresSafeArea()
            
            VStack{
                Text("Sign in")
                    .font(.title)
                    .padding(.bottom, 40)
                    .padding(.top, 16)
                
                Divider()
                    .background(Color.custom.tertiary)
                
                CustomTextField(text: $fName, iconName: "person", placeholder: "Name")
                    .padding(.vertical, 30)
                if showError, let error = validateFname().errorMessage {
                    Text(error)
                        .foregroundColor(Color.red)
                        .padding(.top, -35)
                }
            
                CustomTextField(text: $email, iconName: "envelope", placeholder: "Email")
                    .padding(.bottom, 30)
                if showError, let error = validateEmail().errorMessage {
                    Text(error)
                        .foregroundColor(Color.red)
                        .padding(.top, -35)
                }
                
                CustomTextField(text: $password, iconName: "lock", placeholder: "Password", isPassword: true)
                    .padding(.bottom, 30)
                if showError, let error = validatePassword().errorMessage {
                    Text(error)
                        .foregroundColor(Color.red)
                        .padding(.top, -35)
                }
                
                CustomTextField(text: $confirmPassword, iconName: "lock", placeholder: "Confirm Password", isPassword: true)
                    .padding(.bottom, 30)
                if showError, let error = validateConfirmPasswor().errorMessage {
                    Text(error)
                        .foregroundColor(Color.red)
                        .padding(.top, -35)
                }
                
                Button(action: {
                    if isFormValid{
                        print("Register success")
                    } else {
                        showError = true
                    }
                }) {
                    Text("Sign in")
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.custom.secondary)
                .cornerRadius(10)
            }
            .padding(.horizontal, 20)
        }
        .foregroundColor(Color.custom.text)
    }
    
    var isFormValid: Bool {
        [
            validateFname(),
            validateEmail(),
            validatePassword(),
            validateConfirmPasswor()
        ].allSatisfy {
            if case .success = $0 { return true }
            else{
                return false
            }
        }
    }
    
    func validateFname() -> ValidationResult {
        fName.isEmpty ? .failure("Name is required") : .success
    }
    
    func validateEmail() -> ValidationResult {
        let emailPattern = #"^\S+@\S+\.\S+$"#
        if email.range(of: emailPattern, options: .regularExpression) == nil {
            return.failure("Enter a valid email")
        }
        return .success
    }
        
    func validatePassword() -> ValidationResult {
        if password.count < 8 {
            return .failure("Passwor must be atleast 8 chatacters")
        }
        return .success
    }
    
    func validateConfirmPasswor() -> ValidationResult {
        if confirmPassword.isEmpty {
            return .failure("Please confirm password")
        }
        
        if confirmPassword != password {
            return .failure("Passwors not match")
        }
        return .success
    }
    
}

#Preview {
    RegisterView()
}
