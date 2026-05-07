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
    lazy private var firebaseStorageClient: FirebaseStorageClient = FirebaseStorageClientImpl()
    
    lazy private var exerciseStorage: ExerciseStorage = ExerciseStorage()
    lazy private var storageRepository: StorageRepository = StorageRepositoryImpl(storageClient: firebaseStorageClient)
    
    lazy private var authRepository: AuthRepository = AuthRepositoryImpl(authClient: authClient)
    lazy private var trackedExerciseRepository: TrackedExerciseRepository = TrackedExerciseRepositoryImpl(firestoreClient: firestoreClient)
    lazy private var exerciseRepository: ExerciseRepository = ExerciseRepositoryImpl(storage: exerciseStorage)
    lazy private var postRepository: PostRepository = PostRepositoryImpl(firestoreClient: firestoreClient)
    lazy private var userRepository: UserRepository = UserRepositoryImpl(firestoreClient: firestoreClient)
    lazy private var workoutRepository: WorkoutRepository = WorkoutRepositoryImpl(firestoreClient: firestoreClient)
    lazy private var transactionProvider: TransactionProvider =
    FirestoreTransactionProvider(client: firestoreClient)
    lazy private var routineRepository: RoutineRepository = RoutineRepositoryImpl(firestoreClient: firestoreClient)
    
    lazy private var signOutUseCase: SignOutUseCase = SignOutUseCaseImpl(authRepository: authRepository)
    lazy private var getExercisesUseCase: GetExercisesUseCase = GetExercisesUseCaseImpl(exerciseRepository: exerciseRepository)
    lazy private var createPostUseCase: CreatePostUseCase =
    CreatePostUseCaseImpl(transactionProvider: transactionProvider, trackedExerciseRepo: trackedExerciseRepository, workoutRepo: workoutRepository, postRepo: postRepository, storageRepo: storageRepository)
    lazy private var deletePostUseCase: DeletePostUseCase = DeletePostUseCaseImpl(postRepository: postRepository, trackedExerciseRepository: trackedExerciseRepository)
    lazy private var fetchPostsUseCase: FetchPostsUseCase = FetchPostsUseCaseImpl(postRepository: postRepository, userRepository: userRepository, workoutRepository: workoutRepository, trackedExerciseRepository: trackedExerciseRepository, exerciseRepository: exerciseRepository)
    lazy private var toggleLikeUseCase: ToggleLikeUseCase = ToggleLikeUseCaseImpl(postRepository: postRepository)
    lazy private var getRoutinesUseCase: GetRoutinesUseCase = GetRoutinesUseCaseImpl(routineRepository: routineRepository, trackedExerciseRepository: trackedExerciseRepository, exerciseRepository: exerciseRepository)
    lazy private var getRoutineUseCase: GetRoutineUseCase = GetRoutineUseCaseImpl(routineRepository: routineRepository, exerciseRepository: exerciseRepository, trackedExerciseRepository: trackedExerciseRepository)
    lazy private var getUserUseCase: GetUserUseCase = GetUserUseCaseImpl(userRepository: userRepository)
    lazy private var saveRoutineUseCase: SaveRoutineUseCase = SaveRoutineUseCaseImpl(transactionProvider: transactionProvider, routineRepository: routineRepository, trackedExercisesRepository: trackedExerciseRepository)
    
    let currentUserId: String
    
    init(currentUserId: String) {
        self.currentUserId = currentUserId
    }
    
    @MainActor
    func makeAuthenticatedAppViewModel() -> AuthenticatedAppViewModel {
        AuthenticatedAppViewModel(getExercisesUseCase: getExercisesUseCase)
    }
    
    @MainActor
    private func makeWorkoutViewModel() -> WorkoutViewModel {
        WorkoutViewModel(
            currentUserId: currentUserId,
            getRoutinesUseCase: getRoutinesUseCase
        )
    }
    
    @MainActor
    private func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            currentUserId: currentUserId,
            deletePostUseCase: deletePostUseCase,
            fetchPostsUseCase: fetchPostsUseCase,
            toggleLikeUseCase: toggleLikeUseCase,
            getUserUseCase: getUserUseCase
        )
    }
    
    @MainActor
    private func makeProfileViewModel() -> ProfileViewModel {
        ProfileViewModel()
    }
    
    @MainActor
    private func makeActiveWorkoutViewModel(routineId: String?) -> ActiveWorkoutViewModel {
        ActiveWorkoutViewModel(currentUserId: currentUserId, routineId: routineId, createPostUseCase: createPostUseCase, getExercisesUseCase: getExercisesUseCase, getRoutineUseCase: getRoutineUseCase)
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
    private func makeRoutineViewModel() -> CreateRoutineViewModel {
        CreateRoutineViewModel(currentUserId: currentUserId, getExercisesUseCase: getExercisesUseCase, saveRoutineUseCase: saveRoutineUseCase)
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
    func makeActiveWorkoutView(routineId: String?) -> some View {
        ActiveWorkoutView(viewModel: self.makeActiveWorkoutViewModel(routineId: routineId))
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
        CreateRoutineView(viewModel: self.makeRoutineViewModel())
    }
    
    @MainActor
    func makeCreateRoutineView() -> some View {
        CreateRoutineView(viewModel: self.makeRoutineViewModel())
    }
    
    @MainActor
    func makeWorkoutDetailsView() -> some View {
        WorkoutDetailsView(viewModel: self.makeWorkoutDetailsViewModel())
    }
    
}
