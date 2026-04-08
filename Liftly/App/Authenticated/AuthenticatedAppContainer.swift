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
    lazy private var transactionProvider: TransactionProvider =
        FirestoreTransactionProvider(client: firestoreClient)
    
    lazy private var signOutUseCase: SignOutUseCase = SignOutUseCaseImpl(authRepository: authRepository)
    lazy private var getExercisesUseCase: GetExercisesUseCase = GetExercisesUseCaseImpl(exerciseRepository: exerciseRepository)
    lazy private var createPostUseCase: CreatePostUseCase =
        CreatePostUseCaseImpl(transactionProvider: transactionProvider, trackedExerciseRepo: trakcedExerciseRepository, workoutRepo: workoutRepository, postRepo: postRepository)
    
    let currentUserId: String
    
    init(currentUserId: String) {
        self.currentUserId = currentUserId
    }
    
    @MainActor
    private func makeWorkoutViewModel() -> WorkoutViewModel {
        WorkoutViewModel(
            getExercisesUseCase: getExercisesUseCase,
            createPostUseCase: createPostUseCase
        )
    }
    
    @MainActor
    private func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel()
    }
    
    @MainActor
    private func makeProfileViewModel() -> ProfileViewModel {
        ProfileViewModel()
    }
    
    @MainActor
    private func makeActiveWorkoutViewModel() -> ActiveWorkoutViewModel {
        ActiveWorkoutViewModel()
    }
    
    @MainActor
    private func makeCommentsViewModel() -> CommentsViewModel {
        CommentsViewModel()
    }
    
    @MainActor
    private func makeOtherProfileViewModel() -> OtherProfileViewModel {
        OtherProfileViewModel()
    }
    
    @MainActor
    private func makeRoutineViewModel() -> RoutineViewModel {
        RoutineViewModel()
    }
    
    @MainActor
    private func makeWorkoutDetailsViewModel() -> WorkoutDetailsViewModel {
        WorkoutDetailsViewModel()
    }
    
    
    @MainActor
    func makeHomeView() -> some View {
        HomeView(viewModel: self.makeHomeViewModel())
    }
    
    @MainActor
    func makeWorkoutView() -> some View {
        WorkoutView(viewModel: self.makeWorkoutViewModel())
    }
    
    @MainActor
    func makeProfileView() -> some View {
        ProfileView(viewModel: self.makeProfileViewModel())
    }
    
    @MainActor
    func makeActiveWorkoutView() -> some View {
        ActiveWorkoutView(viewModel: self.makeActiveWorkoutViewModel())
    }
    
    @MainActor
    func makeCommentsView() -> some View {
        CommentsView(viewModel: self.makeCommentsViewModel())
    }
    
    @MainActor
    func makeOtherProfileView() -> some View {
        OtherProfileView(viewModel: self.makeOtherProfileViewModel())
    }
    
    @MainActor
    func makeRoutineView() -> some View {
        RoutineView(viewModel: self.makeRoutineViewModel())
    }
    
    @MainActor
    func makeWorkoutDetailsView() -> some View {
        WorkoutDetailsView(viewModel: self.makeWorkoutDetailsViewModel())
    }
    
}
