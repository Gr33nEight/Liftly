//
//  AuthenticatedAppContainer.swift
//  Liftly
//
//  Created by Natanael Jop on 04/04/2026.
//

import SwiftUI

final class AuthenticatedAppContainer {
    lazy private var authClient: AuthClient = AuthClientImpl()
    lazy private var firestoreClient: FirestoreClient = FirestoreClientImpl()
    
    lazy private var exerciseStorage: ExerciseStorage = ExerciseStorage()
    
    lazy private var authRepository: AuthRepository = AuthRepositoryImpl(authClient: authClient)
    lazy private var trakcedExerciseRepository: TrackedExerciseRepository = TrackedExerciseRepositoryImpl(firestoreClient: firestoreClient)
    lazy private var exerciseRepository: ExerciseRepository = ExerciseRepositoryImpl(storage: exerciseStorage)
    lazy private var postRepository: PostRepository = PostRepositoryImpl(firestoreClient: firestoreClient)
    lazy private var userRepository: UserRepository = UserRepositoryImpl(firestoreClient: firestoreClient)
    lazy private var workoutRepository: WorkoutRepository = WorkoutRepositoryImpl(firestoreClient: firestoreClient)
    
    lazy private var signOutUseCase: SignOutUseCase = SignOutUseCaseImpl(authRepository: authRepository)
    lazy private var getExercisesUseCase: GetExercisesUseCase = GetExercisesUseCaseImpl(exerciseRepository: exerciseRepository)
    
    
    let currentUserId: String
    
    init(currentUserId: String) {
        self.currentUserId = currentUserId
    }
    
    @MainActor
    private func makeWorkoutViewModel() -> WorkoutViewModel {
        WorkoutViewModel(getExercises: getExercisesUseCase)
    }
    
    @MainActor
    func makeHomeView() -> some View {
        VStack {
            Text("Home View")
            Button("Sign Out") {
                do {
                    try self.signOutUseCase.execute()
                } catch {
                    print("Error: ", error.localizedDescription)
                }
            }
        }.padding(20)
    }
    
    @MainActor
    func makeWorkoutView() -> some View {
        WorkoutView(viewModel: self.makeWorkoutViewModel())
    }
    
    @MainActor
    func makeProfileView() -> some View {
        Text("Profile View")
    }
    
    @MainActor
    func makeActiveWorkoutView() -> some View {
        Text("Active Workout View")
    }
    
    @MainActor
    func makeCommentsView() -> some View {
        Text("Comments View")
    }
    
    @MainActor
    func makeOtherProfileView() -> some View {
        Text("Other Profile View")
    }
    
    @MainActor
    func makeRoutineView() -> some View {
        Text("Routine View")
    }
    
    @MainActor
    func makeWorkoutDetailView() -> some View {
        Text("Workout Detail View")
    }
    
}
