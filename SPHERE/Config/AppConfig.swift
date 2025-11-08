//
//  AppConfig.swift
//  SPHERE
//
//  Конфигурация приложения
//

import Foundation

struct AppConfig {
    // Цвета приложения
    static let primaryColor = "blue"
    static let secondaryColor = "purple"
    
    // Настройки XP
    static let baseXPPerLevel = 100
    static let xpMultiplier = 1.5
    
    // Настройки уведомлений
    static let defaultNotificationTime = DateComponents(hour: 9, minute: 0)
    
    // Настройки подписки
    static let subscriptionMonthlyPrice = 299.0
    static let subscriptionYearlyPrice = 2490.0
    
    // Настройки HealthKit
    static let stepsGoal = 10000
    static let caloriesGoal = 500.0
    
    // Настройки геймификации
    static let maxStreakBonus = 1.5 // Множитель XP за длинный streak
    static let streakThreshold = 7 // Дней для бонуса
}

