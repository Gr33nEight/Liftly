//
//  Equipment.swift
//  Liftly
//
//  Created by Natanael Jop on 06/04/2026.
//


enum Equipment: Int, CaseIterable, Codable {
    case none
    case barbell
    case dumbell
    case kettlebell
    case machine
    case plate
    case resistanceBand
    case suspensionBand
    case other
}
