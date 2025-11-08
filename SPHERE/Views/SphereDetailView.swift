//
//  SphereDetailView.swift
//  SPHERE
//
//  Детальный экран сферы
//

import SwiftUI

struct SphereDetailView: View {
    @EnvironmentObject var viewModel: AppViewModel
    let sphere: LifeSphere
    @Environment(\.dismiss) var dismiss
    
    var progress: SphereProgress? {
        viewModel.getSphereProgress(for: sphere)
    }
    
    var challenges: [Challenge] {
        viewModel.getChallenges(for: sphere)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Фоновый градиент
                LinearGradient(
                    colors: [
                        Color(sphere.color).opacity(0.2),
                        Color(sphere.color).opacity(0.1)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Заголовок сферы
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                Color(sphere.color).opacity(0.3),
                                                Color(sphere.color).opacity(0.1)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 100, height: 100)
                                
                                Image(systemName: sphere.icon)
                                    .font(.system(size: 50, weight: .medium))
                                    .foregroundColor(Color(sphere.color))
                            }
                            
                            Text(sphere.rawValue)
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                            
                            Text(sphere.description)
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            if let progress = progress {
                                VStack(spacing: 12) {
                                    HStack {
                                        Text("Уровень \(progress.level)")
                                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                                        
                                        Spacer()
                                        
                                        Text("\(Int(progress.completionPercentage))%")
                                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                                    }
                                    
                                    ProgressView(value: progress.completionPercentage / 100.0)
                                        .progressViewStyle(LinearProgressViewStyle(tint: Color(sphere.color)))
                                        .frame(height: 8)
                                    
                                    HStack {
                                        Text("\(progress.currentXP) / \(progress.totalXP) XP")
                                            .font(.system(size: 14, weight: .medium, design: .rounded))
                                            .foregroundColor(.secondary)
                                        
                                        Spacer()
                                        
                                        if progress.streakDays > 0 {
                                            HStack(spacing: 4) {
                                                Image(systemName: "flame.fill")
                                                    .foregroundColor(.orange)
                                                Text("\(progress.streakDays) дней")
                                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                    }
                                }
                                .padding()
                                .background(.ultraThinMaterial)
                                .cornerRadius(16)
                            }
                        }
                        .padding()
                        
                        // Челленджи
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Челленджи")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .padding(.horizontal)
                            
                            ForEach(challenges) { challenge in
                                ChallengeCard(
                                    challenge: challenge,
                                    isCompleted: viewModel.user?.completedChallenges.contains(challenge.id) ?? false
                                ) {
                                    viewModel.completeChallenge(challenge)
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.bottom, 100)
                }
            }
            .navigationTitle(sphere.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Готово") {
                        dismiss()
                    }
                }
            }
        }
    }
}

