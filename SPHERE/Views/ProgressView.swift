//
//  ProgressView.swift
//  SPHERE
//
//  Экран прогресса
//

import SwiftUI

struct ProgressScreenView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
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
                        // Общий прогресс
                        VStack(spacing: 16) {
                            Text("Общий прогресс")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                            
                            PolygonProgressView(
                                progress: viewModel.getAllSphereProgress(),
                                size: 300
                            )
                            
                            Text("\(Int(viewModel.getOverallProgress()))%")
                                .font(.system(size: 48, weight: .bold, design: .rounded))
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(24)
                        .padding(.horizontal)
                        
                        // Детальная статистика
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Статистика по сферам")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                                .padding(.horizontal)
                            
                            ForEach(viewModel.getAllSphereProgress()) { progress in
                                SphereProgressRow(progress: progress)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Прогресс")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct SphereProgressRow: View {
    let progress: SphereProgress
    
    var body: some View {
        HStack(spacing: 16) {
            // Иконка
            ZStack {
                Circle()
                    .fill(Color(progress.sphere.color).opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Image(systemName: progress.sphere.icon)
                    .font(.system(size: 24))
                    .foregroundColor(Color(progress.sphere.color))
            }
            
            // Информация
            VStack(alignment: .leading, spacing: 6) {
                Text(progress.sphere.rawValue)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                
                HStack {
                    Text("Уровень \(progress.level)")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("\(Int(progress.completionPercentage))%")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                }
                
                ProgressView(value: progress.completionPercentage / 100.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color(progress.sphere.color)))
                    .frame(height: 4)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
    }
}

