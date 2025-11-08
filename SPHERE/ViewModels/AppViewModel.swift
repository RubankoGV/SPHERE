//
//  AppViewModel.swift
//  SPHERE
//
//  Главная ViewModel приложения
//

import Foundation
import SwiftUI
import Combine

@MainActor
class AppViewModel: ObservableObject {
    @Published var user: User?
    @Published var currentChallenges: [Challenge] = []
    @Published var selectedSphere: LifeSphere?
    @Published var isLoading = false
    @Published var showOnboarding = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadUser()
        if user == nil {
            showOnboarding = true
        } else {
            loadChallenges()
        }
    }
    
    func loadUser() {
        if let data = UserDefaults.standard.data(forKey: "userData"),
           let decoded = try? JSONDecoder().decode(User.self, from: data) {
            user = decoded
        }
    }
    
    func saveUser() {
        guard let user = user else { return }
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: "userData")
        }
    }
    
    func createUser(from onboardingData: UserOnboardingData) {
        var newUser = User(name: onboardingData.name)
        newUser.themePreference = .system
        
        // Инициализация прогресса на основе интересов
        for sphere in onboardingData.interests {
            if let index = newUser.sphereProgress.firstIndex(where: { $0.sphere == sphere }) {
                newUser.sphereProgress[index].level = max(1, onboardingData.experienceLevel / 2)
            }
        }
        
        user = newUser
        saveUser()
        loadChallenges()
    }
    
    func loadChallenges() {
        guard let user = user else { return }
        
        var challenges: [Challenge] = []
        for progress in user.sphereProgress {
            let sphereChallenges = ChallengeLibrary.getChallenges(
                for: progress.sphere,
                userLevel: progress.level
            )
            challenges.append(contentsOf: sphereChallenges)
        }
        
        currentChallenges = challenges
    }
    
    func getChallenges(for sphere: LifeSphere) -> [Challenge] {
        guard let user = user else { return [] }
        let progress = user.sphereProgress.first(where: { $0.sphere == sphere })
        let level = progress?.level ?? 1
        return ChallengeLibrary.getChallenges(for: sphere, userLevel: level)
    }
    
    func completeChallenge(_ challenge: Challenge) {
        guard var user = user else { return }
        
        // Добавляем XP пользователю
        user.addXP(challenge.xpReward)
        
        // Добавляем XP сфере
        if let index = user.sphereProgress.firstIndex(where: { $0.sphere == challenge.sphere }) {
            user.sphereProgress[index].addXP(challenge.xpReward)
            user.sphereProgress[index].updateStreak()
        }
        
        // Отмечаем челлендж как выполненный
        if !user.completedChallenges.contains(challenge.id) {
            user.completedChallenges.append(challenge.id)
        }
        
        // Удаляем из активных, если это разовый челлендж
        if !challenge.isDaily {
            user.activeChallenges.removeAll { $0 == challenge.id }
        }
        
        self.user = user
        saveUser()
    }
    
    func getSphereProgress(for sphere: LifeSphere) -> SphereProgress? {
        return user?.sphereProgress.first(where: { $0.sphere == sphere })
    }
    
    func getAllSphereProgress() -> [SphereProgress] {
        return user?.sphereProgress ?? []
    }
    
    func getOverallProgress() -> Double {
        guard let user = user, !user.sphereProgress.isEmpty else { return 0.0 }
        let total = user.sphereProgress.reduce(0.0) { $0 + $1.completionPercentage }
        return total / Double(user.sphereProgress.count)
    }
    
    func syncWithHealthKit() {
        let healthService = ServiceManager.shared.healthKitService
        healthService.getTodaySteps { steps in
            // Обновление прогресса на основе шагов
            if steps >= 10000 {
                // Автоматическое выполнение челленджа "10,000 шагов"
                // Можно добавить логику автоматического выполнения
            }
        }
    }
}

