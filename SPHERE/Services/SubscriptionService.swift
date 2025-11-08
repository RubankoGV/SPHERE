//
//  SubscriptionService.swift
//  SPHERE
//
//  Система подписки
//

import Foundation
import StoreKit

class SubscriptionService: ObservableObject {
    @Published var subscriptionActive = false
    @Published var subscriptionType: SubscriptionType?
    
    enum SubscriptionType: String, CaseIterable {
        case monthly = "com.sphere.monthly"
        case yearly = "com.sphere.yearly"
        
        var displayName: String {
            switch self {
            case .monthly: return "Месячная подписка"
            case .yearly: return "Годовая подписка"
            }
        }
        
        var price: String {
            switch self {
            case .monthly: return "₽299/мес"
            case .yearly: return "₽2490/год"
            }
        }
    }
    
    func checkSubscriptionStatus() {
        // Проверка статуса подписки через StoreKit
        // В реальном приложении здесь будет интеграция с сервером
        subscriptionActive = UserDefaults.standard.bool(forKey: "subscriptionActive")
    }
    
    func purchaseSubscription(_ type: SubscriptionType) {
        // Покупка подписки через StoreKit
        // В реальном приложении здесь будет интеграция с StoreKit
        subscriptionActive = true
        subscriptionType = type
        UserDefaults.standard.set(true, forKey: "subscriptionActive")
        UserDefaults.standard.set(type.rawValue, forKey: "subscriptionType")
    }
    
    func restorePurchases() {
        // Восстановление покупок
        checkSubscriptionStatus()
    }
}

