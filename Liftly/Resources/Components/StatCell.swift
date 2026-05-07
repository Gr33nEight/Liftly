//
//  StatCell.swift
//  Liftly
//
//  Created by Natanael Jop on 16/04/2026.
//

import SwiftUI

struct StatCell: View {
    let title: String
    let value: String
    let alignment: HorizontalAlignment
    var ommitSpacer: Bool = false
    var body: some View {
        HStack {
            if !ommitSpacer {
                Spacer()
            }
            VStack(alignment: alignment, spacing: 8) {
                Text(title)
                    .font(.custom.footnote())
                    .foregroundStyle(Color.custom.tertiary)
                Text(value)
                    .font(.custom.bodyMedium())
                    .foregroundStyle(Color.custom.secondary)
            }
            Spacer()
        }
    }
}
