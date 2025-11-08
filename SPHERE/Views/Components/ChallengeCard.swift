//
//  ChallengeCard.swift
//  SPHERE
//
//  Карточка челленджа
//

import SwiftUI

struct ChallengeCard: View {
    let challenge: Challenge
    let isCompleted: Bool
    let onComplete: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            // Иконка статуса
            ZStack {
                Circle()
                    .fill(
                        isCompleted
                            ? Color.green.opacity(0.2)
                            : Color(challenge.difficulty.color).opacity(0.2)
                    )
                    .frame(width: 50, height: 50)
                
                if isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.green)
                } else {
                    Image(systemName: challenge.sphere.icon)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(Color(challenge.difficulty.color))
                }
            }
            
            // Информация
            VStack(alignment: .leading, spacing: 6) {
                Text(challenge.title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary)
                
                Text(challenge.description)
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack(spacing: 8) {
                    // Сложность
                    Label(challenge.difficulty.rawValue, systemImage: "star.fill")
                        .font(.system(size: 11, weight: .medium, design: .rounded))
                        .foregroundColor(Color(challenge.difficulty.color))
                    
                    // Награда
                    Label("\(challenge.xpReward) XP", systemImage: "sparkles")
                        .font(.system(size: 11, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                    
                    if challenge.isDaily {
                        Label("Ежедневно", systemImage: "repeat")
                            .font(.system(size: 11, weight: .medium, design: .rounded))
                            .foregroundColor(.blue)
                    }
                }
            }
            
            Spacer()
            
            // Кнопка выполнения
            if !isCompleted {
                Button(action: onComplete) {
                    Image(systemName: "checkmark.circle")
                        .font(.system(size: 28))
                        .foregroundColor(Color(challenge.difficulty.color))
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            isCompleted
                                ? Color.green.opacity(0.3)
                                : Color.white.opacity(0.2),
                            lineWidth: 1
                        )
                )
        )
        .opacity(isCompleted ? 0.7 : 1.0)
    }
}

