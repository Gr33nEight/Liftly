//
//  IntExtension.swift
//  Liftly
//
//  Created by Natanael Jop on 13/04/2026.
//

import SwiftUI

extension Int {
    func formatIntoTime() -> String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let secs = self % 60
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, secs)
        } else {
            return String(format: "%02d:%02d", minutes, secs)
        }
    }
}
