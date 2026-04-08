//
//  FontExtension.swift
//  Liftly
//
//  Created by Natanael Jop on 08/04/2026.
//

import SwiftUI

extension Font {
    enum custom {
        
        // MARK: - Headings
        
        static func largeTitle() -> Font {
            .custom("Roboto-Bold", size: 34)
        }
        
        static func title() -> Font {
            .custom("Roboto-Bold", size: 28)
        }
        
        static func title2() -> Font {
            .custom("Roboto-Medium", size: 22)
        }
        
        static func title3() -> Font {
            .custom("Roboto-Medium", size: 20)
        }
        
        // MARK: - Body
        
        static func body() -> Font {
            .custom("Roboto-Regular", size: 17)
        }
        
        static func bodyMedium() -> Font {
            .custom("Roboto-Medium", size: 17)
        }
        
        static func bodyLight() -> Font {
            .custom("Roboto-Light", size: 17)
        }
        
        // MARK: - Secondary
        
        static func subheadline() -> Font {
            .custom("Roboto-Regular", size: 15)
        }
        
        static func footnote() -> Font {
            .custom("Roboto-Regular", size: 13)
        }
        
        static func caption() -> Font {
            .custom("Roboto-Light", size: 12)
        }
        
        // MARK: - Special (fitness app use case)
        
        static func metricLarge() -> Font {
            .custom("Roboto-Bold", size: 32)
        }
        
        static func metricMedium() -> Font {
            .custom("Roboto-Bold", size: 24)
        }
        
        static func metricSmall() -> Font {
            .custom("Roboto-Medium", size: 18)
        }
    }
}
