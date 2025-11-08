//
//  SphereCard.swift
//  SPHERE
//
//  Карточка сферы жизни
//

import SwiftUI

struct SphereCard: View {
    let progress: SphereProgress
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 12) {
                // Иконка сферы
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(progress.sphere.color).opacity(0.3),
                                    Color(progress.sphere.color).opacity(0.1)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: progress.sphere.icon)
                        .font(.system(size: 28, weight: .medium))
                        .foregroundColor(Color(progress.sphere.color))
                }
                
                // Название
                Text(progress.sphere.rawValue)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                // Прогресс
                VStack(spacing: 4) {
                    Text("Уровень \(progress.level)")
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                    
                    ProgressView(value: progress.completionPercentage / 100.0)
                        .progressViewStyle(LinearProgressViewStyle(tint: Color(progress.sphere.color)))
                        .frame(height: 4)
                    
                    Text("\(Int(progress.completionPercentage))%")
                        .font(.system(size: 10, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                }
                
                // Streak
                if progress.streakDays > 0 {
                    HStack(spacing: 4) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 10))
                            .foregroundColor(.orange)
                        Text("\(progress.streakDays)")
                            .font(.system(size: 10, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
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
            )
            .shadow(color: Color(progress.sphere.color).opacity(0.2), radius: 10, x: 0, y: 5)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

