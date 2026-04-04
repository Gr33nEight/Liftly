//
//  UnAuthenticatedAppRootView.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import SwiftUI

struct UnAuthenticatedAppRootView: View {
    private let container: UnAuthenticatedAppContainer
    
    init(container: UnAuthenticatedAppContainer) {
        self.container = container
    }
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Text("UnAuthenticated")
                .font(.title)
            
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button("Sign In") {
                Task {
                    do {
                        try await container.signUpUseCase.execute(email: email, password: password)
                    } catch {
                        print("Error: ", error.localizedDescription)
                    }
                }
            }
        }.padding(20)
    }
}
