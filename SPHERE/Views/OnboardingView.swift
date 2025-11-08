//
//  OnboardingView.swift
//  SPHERE
//
//  Экран онбординга
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var currentStep = 0
    @State private var name = ""
    @State private var age = 20
    @State private var selectedInterests: Set<LifeSphere> = []
    @State private var experienceLevel = 5
    @State private var goals: [String] = []
    @State private var newGoal = ""
    
    var body: some View {
        ZStack {
            // Фоновый градиент
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.3),
                    Color.purple.opacity(0.3)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Прогресс
                ProgressView(value: Double(currentStep) / 4.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: .white))
                    .padding(.horizontal, 40)
                    .padding(.top, 20)
                
                TabView(selection: $currentStep) {
                    // Шаг 1: Имя
                    nameStep
                        .tag(0)
                    
                    // Шаг 2: Возраст
                    ageStep
                        .tag(1)
                    
                    // Шаг 3: Интересы
                    interestsStep
                        .tag(2)
                    
                    // Шаг 4: Опыт
                    experienceStep
                        .tag(3)
                    
                    // Шаг 5: Цели
                    goalsStep
                        .tag(4)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // Кнопки навигации
                HStack {
                    if currentStep > 0 {
                        Button("Назад") {
                            withAnimation {
                                currentStep -= 1
                            }
                        }
                        .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Button(currentStep == 4 ? "Начать" : "Далее") {
                        if currentStep == 4 {
                            completeOnboarding()
                        } else {
                            withAnimation {
                                currentStep += 1
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(currentStep == 0 && name.isEmpty)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
        }
    }
    
    private var nameStep: some View {
        VStack(spacing: 30) {
            Text("Добро пожаловать в SPHERE")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Text("Твой персональный трекер развития")
                .font(.system(size: 18, weight: .regular, design: .rounded))
                .foregroundColor(.white.opacity(0.8))
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Как тебя зовут?")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                
                TextField("Твоё имя", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 18, design: .rounded))
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding(.top, 60)
    }
    
    private var ageStep: some View {
        VStack(spacing: 30) {
            Text("Сколько тебе лет?")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Text("\(age)")
                .font(.system(size: 64, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Slider(value: Binding(
                get: { Double(age) },
                set: { age = Int($0) }
            ), in: 18...23, step: 1)
            .tint(.white)
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding(.top, 60)
    }
    
    private var interestsStep: some View {
        VStack(spacing: 20) {
            Text("Какие сферы тебя интересуют?")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Text("Выбери несколько")
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .foregroundColor(.white.opacity(0.8))
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(LifeSphere.allCases) { sphere in
                        InterestButton(
                            sphere: sphere,
                            isSelected: selectedInterests.contains(sphere)
                        ) {
                            if selectedInterests.contains(sphere) {
                                selectedInterests.remove(sphere)
                            } else {
                                selectedInterests.insert(sphere)
                            }
                        }
                    }
                }
                .padding(.horizontal, 40)
            }
        }
        .padding(.top, 40)
    }
    
    private var experienceStep: some View {
        VStack(spacing: 30) {
            Text("Твой уровень опыта?")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Text("\(experienceLevel)/10")
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Slider(value: Binding(
                get: { Double(experienceLevel) },
                set: { experienceLevel = Int($0) }
            ), in: 1...10, step: 1)
            .tint(.white)
            .padding(.horizontal, 40)
            
            Text(experienceDescription)
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding(.top, 60)
    }
    
    private var goalsStep: some View {
        VStack(spacing: 30) {
            Text("Твои цели?")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Text("Добавь несколько целей")
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .foregroundColor(.white.opacity(0.8))
            
            HStack {
                TextField("Моя цель...", text: $newGoal)
                    .textFieldStyle(.roundedBorder)
                
                Button("Добавить") {
                    if !newGoal.isEmpty {
                        goals.append(newGoal)
                        newGoal = ""
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal, 40)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(goals, id: \.self) { goal in
                        HStack {
                            Text(goal)
                                .font(.system(size: 16, design: .rounded))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button {
                                goals.removeAll { $0 == goal }
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.white.opacity(0.6))
                            }
                        }
                        .padding()
                        .background(.white.opacity(0.2))
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 40)
            }
            
            Spacer()
        }
        .padding(.top, 40)
    }
    
    private var experienceDescription: String {
        switch experienceLevel {
        case 1...3: return "Начинающий - отличное время для старта!"
        case 4...6: return "Средний уровень - продолжаем развиваться"
        case 7...8: return "Продвинутый - ты на правильном пути"
        default: return "Эксперт - вдохновляй других!"
        }
    }
    
    private func completeOnboarding() {
        let data = UserOnboardingData(
            name: name,
            age: age,
            interests: Array(selectedInterests),
            experienceLevel: experienceLevel,
            goals: goals,
            notificationTime: nil
        )
        viewModel.createUser(from: data)
        viewModel.showOnboarding = false
    }
}

struct InterestButton: View {
    let sphere: LifeSphere
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: sphere.icon)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .white : Color(sphere.color))
                
                Text(sphere.rawValue)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(isSelected ? .white : .white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? Color(sphere.color) : .white.opacity(0.2))
            )
        }
    }
}

