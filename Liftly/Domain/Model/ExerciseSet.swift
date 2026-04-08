//
//  ExerciseSet.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//


struct ExerciseSet {
    var type: SetType
    var value: ExerciseValue
}

extension ExerciseSet {
    static func create(
        type: SetType,
        exerciseType: ExerciseType,
        value: ExerciseValue
    ) -> ExerciseSet {

        if value.matches(exerciseType) {
            return ExerciseSet(
                type: type,
                value: value
            )
        } else {
            return ExerciseSet(
                type: type,
                value: exerciseType.defaultValue()
            )
        }
    }
}
