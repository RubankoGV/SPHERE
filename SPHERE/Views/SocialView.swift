//
//  SocialView.swift
//  SPHERE
//
//  Социальные функции
//

import SwiftUI

struct SocialView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var friends: [Friend] = []
    @State private var leaderboard: [LeaderboardEntry] = []
    
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
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Таблица лидеров
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Таблица лидеров")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                            
                            ForEach(leaderboard) { entry in
                                LeaderboardRow(entry: entry)
                            }
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(24)
                        .padding(.horizontal)
                        
                        // Друзья
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Друзья")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                            
                            ForEach(friends) { friend in
                                FriendRow(friend: friend)
                            }
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(24)
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Социальная сеть")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct Friend: Identifiable {
    let id: UUID
    let name: String
    let level: Int
    let totalXP: Int
    let avatarURL: String?
}

struct LeaderboardEntry: Identifiable {
    let id: UUID
    let rank: Int
    let name: String
    let level: Int
    let totalXP: Int
}

struct FriendRow: View {
    let friend: Friend
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.blue, Color.purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 50, height: 50)
                
                Text(friend.name.prefix(1).uppercased())
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(friend.name)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                
                Text("Уровень \(friend.level) • \(friend.totalXP) XP")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(.white.opacity(0.1))
        .cornerRadius(12)
    }
}

struct LeaderboardRow: View {
    let entry: LeaderboardEntry
    
    var body: some View {
        HStack {
            Text("#\(entry.rank)")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(entry.rank <= 3 ? .yellow : .secondary)
                .frame(width: 40)
            
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.blue, Color.purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 50, height: 50)
                
                Text(entry.name.prefix(1).uppercased())
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.name)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                
                Text("Уровень \(entry.level) • \(entry.totalXP) XP")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(.white.opacity(0.1))
        .cornerRadius(12)
    }
}

