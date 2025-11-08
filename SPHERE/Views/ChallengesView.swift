//
//  ChallengesView.swift
//  SPHERE
//
//  Экран всех челленджей
//

import SwiftUI

struct ChallengesView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var selectedSphere: LifeSphere?
    @State private var filterDifficulty: ChallengeDifficulty?
    
    var filteredChallenges: [Challenge] {
        var challenges = viewModel.currentChallenges
        
        if let sphere = selectedSphere {
            challenges = challenges.filter { $0.sphere == sphere }
        }
        
        if let difficulty = filterDifficulty {
            challenges = challenges.filter { $0.difficulty == difficulty }
        }
        
        return challenges
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.1),
                        Color.purple.opacity(0.1)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Фильтры
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            FilterChip(
                                title: "Все",
                                isSelected: selectedSphere == nil && filterDifficulty == nil
                            ) {
                                selectedSphere = nil
                                filterDifficulty = nil
                            }
                            
                            ForEach(LifeSphere.allCases) { sphere in
                                FilterChip(
                                    title: sphere.rawValue,
                                    isSelected: selectedSphere == sphere
                                ) {
                                    selectedSphere = selectedSphere == sphere ? nil : sphere
                                }
                            }
                            
                            ForEach(ChallengeDifficulty.allCases) { difficulty in
                                FilterChip(
                                    title: difficulty.rawValue,
                                    isSelected: filterDifficulty == difficulty
                                ) {
                                    filterDifficulty = filterDifficulty == difficulty ? nil : difficulty
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 12)
                    
                    // Список челленджей
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(filteredChallenges) { challenge in
                                ChallengeCard(
                                    challenge: challenge,
                                    isCompleted: viewModel.user?.completedChallenges.contains(challenge.id) ?? false
                                ) {
                                    viewModel.completeChallenge(challenge)
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Челленджи")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isSelected ? Color.blue : Color.white.opacity(0.2))
                )
        }
    }
}

extension ChallengeDifficulty: Identifiable {
    public var id: String { rawValue }
}

