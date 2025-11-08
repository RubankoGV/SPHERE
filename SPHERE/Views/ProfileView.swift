//
//  ProfileView.swift
//  SPHERE
//
//  Экран профиля
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var showSettings = false
    
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
                        // Аватар и имя
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.blue, Color.purple],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 100, height: 100)
                                
                                Text((viewModel.user?.name.prefix(1) ?? "U").uppercased())
                                    .font(.system(size: 48, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            
                            Text(viewModel.user?.name ?? "Пользователь")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                            
                            Text("Уровень \(viewModel.user?.level ?? 1)")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(24)
                        .padding(.horizontal)
                        
                        // Статистика
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Статистика")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                            
                            StatCard(
                                icon: "sparkles",
                                title: "Всего XP",
                                value: "\(viewModel.user?.totalXP ?? 0)"
                            )
                            
                            StatCard(
                                icon: "checkmark.circle.fill",
                                title: "Выполнено челленджей",
                                value: "\(viewModel.user?.completedChallenges.count ?? 0)"
                            )
                            
                            StatCard(
                                icon: "flame.fill",
                                title: "Средний streak",
                                value: "\(averageStreak) дней"
                            )
                        }
                        .padding(.horizontal)
                        
                        // Настройки
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Настройки")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                            
                            SettingsRow(icon: "bell.fill", title: "Уведомления") {
                                // Настройки уведомлений
                            }
                            
                            SettingsRow(icon: "paintbrush.fill", title: "Тема") {
                                // Настройки темы
                            }
                            
                            SettingsRow(icon: "person.2.fill", title: "Друзья") {
                                // Социальные функции
                            }
                            
                            SettingsRow(icon: "crown.fill", title: "Подписка") {
                                // Подписка будет открыта через sheet
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Профиль")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                }
            }
        }
    }
    
    private var averageStreak: Int {
        guard let user = viewModel.user else { return 0 }
        let total = user.sphereProgress.reduce(0) { $0 + $1.streakDays }
        return total / user.sphereProgress.count
    }
}

struct StatCard: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.blue)
                .frame(width: 50)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                
                Text(value)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }
            
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
                    .frame(width: 30)
                
                Text(title)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
        }
    }
}

