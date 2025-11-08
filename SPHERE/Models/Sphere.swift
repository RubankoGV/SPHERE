//
//  Sphere.swift
//  SPHERE
//
//  Модель сферы жизни
//

import Foundation

enum LifeSphere: String, CaseIterable, Identifiable, Codable {
    case health = "Здоровье"
    case beauty = "Красота"
    case study = "Учёба"
    case mentalHealth = "Ментальное здоровье"
    case sport = "Спорт"
    case personalLife = "Личная жизнь"
    case finances = "Финансы"
    case selfDevelopment = "Саморазвитие"
    case purpose = "Целеустремлённость"
    case productivity = "Продуктивность"
    case career = "Карьера"
    case communication = "Навыки общения"
    case organization = "Организованность"
    case discipline = "Дисциплина"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .health: return "heart.fill"
        case .beauty: return "sparkles"
        case .study: return "book.fill"
        case .mentalHealth: return "brain.head.profile"
        case .sport: return "figure.run"
        case .personalLife: return "person.2.fill"
        case .finances: return "dollarsign.circle.fill"
        case .selfDevelopment: return "star.fill"
        case .purpose: return "target"
        case .productivity: return "bolt.fill"
        case .career: return "briefcase.fill"
        case .communication: return "message.fill"
        case .organization: return "checklist"
        case .discipline: return "shield.fill"
        }
    }
    
    var color: String {
        switch self {
        case .health: return "healthColor"
        case .beauty: return "beautyColor"
        case .study: return "studyColor"
        case .mentalHealth: return "mentalColor"
        case .sport: return "sportColor"
        case .personalLife: return "personalColor"
        case .finances: return "financeColor"
        case .selfDevelopment: return "developmentColor"
        case .purpose: return "purposeColor"
        case .productivity: return "productivityColor"
        case .career: return "careerColor"
        case .communication: return "communicationColor"
        case .organization: return "organizationColor"
        case .discipline: return "disciplineColor"
        }
    }
    
    var description: String {
        switch self {
        case .health: return "Физическое здоровье и благополучие"
        case .beauty: return "Уход за собой и внешним видом"
        case .study: return "Образование и получение знаний"
        case .mentalHealth: return "Психическое здоровье и эмоциональное равновесие"
        case .sport: return "Физическая активность и тренировки"
        case .personalLife: return "Отношения и личная жизнь"
        case .finances: return "Финансовое планирование и управление"
        case .selfDevelopment: return "Личностный рост и развитие"
        case .purpose: return "Постановка и достижение целей"
        case .productivity: return "Эффективность и результативность"
        case .career: return "Профессиональное развитие"
        case .communication: return "Навыки общения и взаимодействия"
        case .organization: return "Порядок и структурированность"
        case .discipline: return "Самоконтроль и последовательность"
        }
    }
}

struct SphereProgress: Identifiable, Codable {
    let id: UUID
    let sphere: LifeSphere
    var level: Int
    var currentXP: Int
    var totalXP: Int
    var completionPercentage: Double
    var streakDays: Int
    var lastActivityDate: Date?
    
    init(sphere: LifeSphere) {
        self.id = UUID()
        self.sphere = sphere
        self.level = 1
        self.currentXP = 0
        self.totalXP = 100
        self.completionPercentage = 0.0
        self.streakDays = 0
        self.lastActivityDate = nil
    }
    
    var xpToNextLevel: Int {
        totalXP - currentXP
    }
    
    mutating func addXP(_ amount: Int) {
        currentXP += amount
        if currentXP >= totalXP {
            level += 1
            currentXP = currentXP - totalXP
            totalXP = Int(Double(totalXP) * 1.5) // Увеличение опыта для следующего уровня
        }
        updateCompletionPercentage()
    }
    
    mutating func updateCompletionPercentage() {
        completionPercentage = min(100.0, Double(currentXP) / Double(totalXP) * 100.0)
    }
    
    mutating func updateStreak() {
        let today = Calendar.current.startOfDay(for: Date())
        if let lastDate = lastActivityDate {
            let lastDay = Calendar.current.startOfDay(for: lastDate)
            let daysDiff = Calendar.current.dateComponents([.day], from: lastDay, to: today).day ?? 0
            
            if daysDiff == 1 {
                streakDays += 1
            } else if daysDiff > 1 {
                streakDays = 1
            }
        } else {
            streakDays = 1
        }
        lastActivityDate = Date()
    }
}

