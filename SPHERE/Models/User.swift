//
//  User.swift
//  SPHERE
//
//  Модель пользователя
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    var name: String
    var email: String?
    var avatarURL: String?
    var level: Int
    var totalXP: Int
    var joinDate: Date
    var themePreference: ThemePreference
    var notificationEnabled: Bool
    var subscriptionActive: Bool
    var subscriptionExpiryDate: Date?
    
    var sphereProgress: [SphereProgress]
    var completedChallenges: [UUID]
    var activeChallenges: [UUID]
    var friends: [UUID]
    
    init(name: String, email: String? = nil) {
        self.id = UUID()
        self.name = name
        self.email = email
        self.level = 1
        self.totalXP = 0
        self.joinDate = Date()
        self.themePreference = .system
        self.notificationEnabled = true
        self.subscriptionActive = false
        self.subscriptionExpiryDate = nil
        
        self.sphereProgress = LifeSphere.allCases.map { SphereProgress(sphere: $0) }
        self.completedChallenges = []
        self.activeChallenges = []
        self.friends = []
    }
    
    var xpToNextLevel: Int {
        level * 100
    }
    
    mutating func addXP(_ amount: Int) {
        totalXP += amount
        let newLevel = (totalXP / 100) + 1
        if newLevel > level {
            level = newLevel
        }
    }
}

enum ThemePreference: String, Codable {
    case light = "light"
    case dark = "dark"
    case system = "system"
}

struct UserOnboardingData: Codable {
    var name: String
    var age: Int
    var interests: [LifeSphere]
    var experienceLevel: Int // 1-10
    var goals: [String]
    var notificationTime: Date?
}

