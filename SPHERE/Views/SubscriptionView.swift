//
//  SubscriptionView.swift
//  SPHERE
//
//  Экран подписки
//

import SwiftUI

struct SubscriptionView: View {
    @EnvironmentObject var subscriptionService: SubscriptionService
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.3),
                        Color.purple.opacity(0.3)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // Заголовок
                    VStack(spacing: 12) {
                        Image(systemName: "crown.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.yellow)
                        
                        Text("SPHERE Premium")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                        
                        Text("Раскрой весь потенциал")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 40)
                    
                    // Преимущества
                    VStack(alignment: .leading, spacing: 16) {
                        FeatureRow(icon: "infinity", text: "Неограниченные челленджи")
                        FeatureRow(icon: "chart.line.uptrend.xyaxis", text: "Расширенная аналитика")
                        FeatureRow(icon: "person.2.fill", text: "Социальные функции")
                        FeatureRow(icon: "bell.badge.fill", text: "Персональные уведомления")
                        FeatureRow(icon: "sparkles", text: "Эксклюзивные награды")
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    // Планы подписки
                    VStack(spacing: 16) {
                        ForEach(SubscriptionService.SubscriptionType.allCases, id: \.self) { type in
                            SubscriptionPlanCard(type: type) {
                                subscriptionService.purchaseSubscription(type)
                                dismiss()
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Восстановление покупок
                    Button("Восстановить покупки") {
                        subscriptionService.restorePurchases()
                    }
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                    
                    Spacer()
                }
            }
            .navigationTitle("Подписка")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Закрыть") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.blue)
                .frame(width: 30)
            
            Text(text)
                .font(.system(size: 16, weight: .medium, design: .rounded))
            
            Spacer()
        }
    }
}

struct SubscriptionPlanCard: View {
    let type: SubscriptionService.SubscriptionType
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(type.displayName)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    
                    Text(type.price)
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                }
                
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

