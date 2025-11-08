//
//  ServiceManager.swift
//  SPHERE
//
//  Менеджер всех сервисов
//

import Foundation
import SwiftUI

class ServiceManager: ObservableObject {
    static let shared = ServiceManager()
    
    let healthKitService = HealthKitService()
    let calendarService = CalendarService()
    let remindersService = RemindersService()
    let subscriptionService = SubscriptionService()
    let notificationService = NotificationService()
    
    private init() {}
    
    func initializeServices() {
        // Запрос разрешений
        healthKitService.requestAuthorization()
        calendarService.requestAccess { _ in }
        remindersService.requestAccess { _ in }
        notificationService.requestAuthorization()
        
        // Проверка подписки
        subscriptionService.checkSubscriptionStatus()
    }
}

