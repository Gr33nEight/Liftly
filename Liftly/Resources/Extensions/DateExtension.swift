//
//  DateExtension.swift
//  Liftly
//
//  Created by Natanael Jop on 07/05/2026.
//

import SwiftUI

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
