//
//  HomeView.swift
//  SPHERE
//
//  Главный экран
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Главная вкладка
            MainDashboardView()
                .tabItem {
                    Label("Главная", systemImage: "house.fill")
                }
                .tag(0)
            
            // Челленджи
            ChallengesView()
                .tabItem {
                    Label("Челленджи", systemImage: "target")
                }
                .tag(1)
            
            // Прогресс
            ProgressScreenView()
                .tabItem {
                    Label("Прогресс", systemImage: "chart.polygon.fill")
                }
                .tag(2)
            
            // Профиль
            ProfileView()
                .tabItem {
                    Label("Профиль", systemImage: "person.fill")
                }
                .tag(3)
        }
        .accentColor(.blue)
    }
}

struct MainDashboardView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                // Фоновый градиент
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
                        // Приветствие
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Привет, \(viewModel.user?.name ?? "Друг")!")
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                
                                Text("Уровень \(viewModel.user?.level ?? 1)")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            // Общий XP
                            VStack {
                                Text("\(viewModel.user?.totalXP ?? 0)")
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                                Text("XP")
                                    .font(.system(size: 12, weight: .medium, design: .rounded))
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(16)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        
                        // Многоугольник прогресса
                        VStack(spacing: 16) {
                            Text("Твой SPHERE")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                            
                            PolygonProgressView(
                                progress: viewModel.getAllSphereProgress(),
                                size: 280
                            )
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(24)
                        .padding(.horizontal)
                        
                        // Сферы жизни
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Сферы жизни")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .padding(.horizontal)
                            
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 16) {
                                ForEach(viewModel.getAllSphereProgress()) { progress in
                                    SphereCard(progress: progress) {
                                        viewModel.selectedSphere = progress.sphere
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 100)
                }
            }
            .navigationTitle("SPHERE")
            .navigationBarTitleDisplayMode(.large)
            .sheet(item: $viewModel.selectedSphere) { sphere in
                SphereDetailView(sphere: sphere)
            }
        }
    }
}

extension LifeSphere: Identifiable {}

