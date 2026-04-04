//
//  UnAuthenticatedAppContainer.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import Foundation

final class UnAuthenticatedAppContainer {
    lazy private var authClient: AuthClient = AuthClientImpl()
    lazy private var firestoreClient: FirestoreClient = FirestoreClientImpl()
    
    lazy private var authRepository: AuthRepository = AuthRepositoryImpl(authClient: authClient, firestoreClient: firestoreClient)
    
    lazy var signUpUseCase: SignUpUseCase = SignUpUseCaseImpl(authRepository: authRepository)
}
