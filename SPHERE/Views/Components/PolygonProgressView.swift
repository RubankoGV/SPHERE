//
//  PolygonProgressView.swift
//  SPHERE
//
//  Визуализация прогресса в виде многоугольника
//

import SwiftUI

struct PolygonProgressView: View {
    let progress: [SphereProgress]
    let size: CGFloat
    
    @State private var animatedProgress: [Double] = []
    
    init(progress: [SphereProgress], size: CGFloat = 200) {
        self.progress = progress
        self.size = size
        let count = max(progress.count, 14) // Минимум 14 сфер
        _animatedProgress = State(initialValue: Array(repeating: 0.0, count: count))
    }
    
    var body: some View {
        ZStack {
            // Фоновый многоугольник
            PolygonShape(points: normalizedPoints(for: Array(repeating: 1.0, count: max(progress.count, 14))))
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.1), Color.white.opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
            
            // Прогресс многоугольник
            PolygonShape(points: normalizedPoints)
                .fill(
                    LinearGradient(
                        colors: progressColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .opacity(0.6)
                )
                .overlay(
                    PolygonShape(points: normalizedPoints)
                        .stroke(
                            LinearGradient(
                                colors: progressColors,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 3
                        )
                )
                .shadow(color: Color.blue.opacity(0.3), radius: 20, x: 0, y: 0)
            
            // Центральный круг с общим прогрессом
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.white.opacity(0.2),
                            Color.blue.opacity(0.1)
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: size * 0.3
                    )
                )
                .frame(width: size * 0.3, height: size * 0.3)
                .overlay(
                    Text("\(Int(overallProgress))%")
                        .font(.system(size: size * 0.08, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                )
        }
        .frame(width: size, height: size)
        .onAppear {
            animateProgress()
        }
    }
    
    private var normalizedPoints: [CGPoint] {
        normalizedPoints(for: animatedProgress)
    }
    
    private func normalizedPoints(for values: [Double]) -> [CGPoint] {
        let center = CGPoint(x: size / 2, y: size / 2)
        let radius = size * 0.4
        let count = max(values.count, 14) // Минимум 14 сфер
        let angleStep = 2 * .pi / Double(count)
        
        return values.enumerated().map { index, value in
            let angle = angleStep * Double(index) - .pi / 2
            let distance = radius * value
            return CGPoint(
                x: center.x + cos(angle) * distance,
                y: center.y + sin(angle) * distance
            )
        }
    }
    
    private var progressColors: [Color] {
        progress.map { sphereProgress in
            Color(sphereProgress.sphere.color)
        }
    }
    
    private var overallProgress: Double {
        guard !progress.isEmpty else { return 0 }
        return progress.reduce(0.0) { $0 + $1.completionPercentage } / Double(progress.count)
    }
    
    private func animateProgress() {
        let targetProgress = progress.map { $0.completionPercentage / 100.0 }
        
        for (index, target) in targetProgress.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05) {
                withAnimation(.spring(response: 1.5, dampingFraction: 0.8)) {
                    animatedProgress[index] = target
                }
            }
        }
    }
}

struct PolygonShape: Shape {
    let points: [CGPoint]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard !points.isEmpty else { return path }
        
        path.move(to: points[0])
        for point in points.dropFirst() {
            path.addLine(to: point)
        }
        path.closeSubpath()
        
        return path
    }
}

// Цвета для каждой сферы
extension Color {
    static let healthColor = Color(red: 1.0, green: 0.3, blue: 0.3)
    static let beautyColor = Color(red: 1.0, green: 0.5, blue: 0.8)
    static let studyColor = Color(red: 0.3, green: 0.7, blue: 1.0)
    static let mentalColor = Color(red: 0.6, green: 0.4, blue: 1.0)
    static let sportColor = Color(red: 0.2, green: 0.8, blue: 0.4)
    static let personalColor = Color(red: 1.0, green: 0.7, blue: 0.2)
    static let financeColor = Color(red: 0.3, green: 0.9, blue: 0.5)
    static let developmentColor = Color(red: 1.0, green: 0.9, blue: 0.2)
    static let purposeColor = Color(red: 0.9, green: 0.3, blue: 0.9)
    static let productivityColor = Color(red: 0.2, green: 0.6, blue: 1.0)
    static let careerColor = Color(red: 0.4, green: 0.4, blue: 0.9)
    static let communicationColor = Color(red: 0.5, green: 0.8, blue: 1.0)
    static let organizationColor = Color(red: 0.7, green: 0.5, blue: 1.0)
    static let disciplineColor = Color(red: 0.9, green: 0.5, blue: 0.2)
    
    init(_ name: String) {
        switch name {
        case "healthColor": self = .healthColor
        case "beautyColor": self = .beautyColor
        case "studyColor": self = .studyColor
        case "mentalColor": self = .mentalColor
        case "sportColor": self = .sportColor
        case "personalColor": self = .personalColor
        case "financeColor": self = .financeColor
        case "developmentColor": self = .developmentColor
        case "purposeColor": self = .purposeColor
        case "productivityColor": self = .productivityColor
        case "careerColor": self = .careerColor
        case "communicationColor": self = .communicationColor
        case "organizationColor": self = .organizationColor
        case "disciplineColor": self = .disciplineColor
        default: self = .blue
        }
    }
}

