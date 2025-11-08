//
//  Extensions.swift
//  SPHERE
//
//  Полезные расширения
//

import Foundation
import SwiftUI

extension View {
    func glassEffect() -> some View {
        self
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.3),
                                Color.white.opacity(0.1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
    }
}

extension Date {
    func isToday() -> Bool {
        Calendar.current.isDateInToday(self)
    }
    
    func isSameDay(as date: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: date)
    }
}

extension Array where Element == SphereProgress {
    func averageProgress() -> Double {
        guard !isEmpty else { return 0.0 }
        return reduce(0.0) { $0 + $1.completionPercentage } / Double(count)
    }
}

