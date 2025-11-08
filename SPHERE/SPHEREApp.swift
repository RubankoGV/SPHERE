//
//  SPHEREApp.swift
//  SPHERE
//
//  Главный файл приложения
//

import SwiftUI

@main
struct SPHEREApp: App {
    @StateObject private var viewModel = AppViewModel()
    
    init() {
        // Инициализация сервисов при запуске
        ServiceManager.shared.initializeServices()
    }
    
    var body: some Scene {
        WindowGroup {
            if viewModel.showOnboarding {
                OnboardingView()
                    .environmentObject(viewModel)
            } else {
                HomeView()
                    .environmentObject(viewModel)
            }
        }
    }
}

