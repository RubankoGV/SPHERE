# Инструкция по настройке проекта SPHERE

## Шаги для запуска проекта в Xcode

### 1. Создание проекта Xcode

1. Откройте Xcode
2. Выберите `File` → `New` → `Project`
3. Выберите `iOS` → `App`
4. Заполните:
   - **Product Name**: `SPHERE`
   - **Interface**: `SwiftUI`
   - **Language**: `Swift`
   - **Storage**: `None` (или `SwiftUI App` если доступно)
5. Выберите место сохранения и создайте проект

### 2. Добавление файлов в проект

1. В Xcode удалите автоматически созданные файлы (`ContentView.swift` и т.д.)
2. Перетащите всю папку `SPHERE` из файловой системы в проект Xcode
3. Убедитесь, что выбрано:
   - ✅ `Copy items if needed`
   - ✅ `Create groups`
   - ✅ Target: `SPHERE`

### 3. Настройка Info.plist

1. Откройте `Info.plist` в проекте
2. Добавьте следующие ключи (или скопируйте из `SPHERE/Info.plist`):
   - `NSHealthShareUsageDescription`
   - `NSHealthUpdateUsageDescription`
   - `NSCalendarsUsageDescription`
   - `NSRemindersUsageDescription`
   - `NSUserNotificationsUsageDescription`

### 4. Настройка Capabilities

1. Выберите проект в навигаторе
2. Перейдите на вкладку `Signing & Capabilities`
3. Добавьте следующие capabilities:
   - ✅ **HealthKit**
   - ✅ **Background Modes** → `Background fetch`, `Remote notifications`

### 5. Настройка главного файла

Убедитесь, что в настройках проекта:
- **Main Interface**: оставьте пустым (SwiftUI App не требует Storyboard)
- **Deployment Target**: iOS 16.0 или выше

### 6. Проверка импортов

Убедитесь, что все файлы имеют правильные импорты:
- `import SwiftUI` для всех View файлов
- `import Foundation` для моделей и сервисов
- `import HealthKit` для HealthKitService
- `import EventKit` для CalendarService и RemindersService
- `import UserNotifications` для NotificationService
- `import StoreKit` для SubscriptionService

### 7. Запуск проекта

1. Выберите симулятор или подключенное устройство
2. Нажмите `⌘R` или кнопку `Run`
3. При первом запуске приложение запросит разрешения для:
   - HealthKit
   - Calendar
   - Reminders
   - Notifications

## Возможные проблемы и решения

### Ошибка компиляции: "Cannot find type in scope"

**Решение**: Убедитесь, что все файлы добавлены в Target Membership:
1. Выберите файл в навигаторе
2. Откройте `File Inspector` (⌘⌥1)
3. В разделе `Target Membership` убедитесь, что `SPHERE` отмечен

### Ошибка: "Missing required capability"

**Решение**: Добавьте необходимые capabilities в настройках проекта (см. шаг 4)

### Ошибка: "Info.plist not found"

**Решение**: 
1. Убедитесь, что `Info.plist` находится в корне проекта
2. В настройках проекта (`Build Settings`) найдите `Info.plist File`
3. Укажите путь: `SPHERE/Info.plist`

### HealthKit не работает на симуляторе

**Решение**: HealthKit требует реальное устройство. Тестируйте на физическом iPhone.

## Структура файлов

```
SPHERE/
├── SPHEREApp.swift          # Точка входа приложения
├── Info.plist               # Конфигурация разрешений
├── Models/                  # Модели данных
│   ├── Sphere.swift
│   ├── Challenge.swift
│   └── User.swift
├── ViewModels/              # ViewModels
│   └── AppViewModel.swift
├── Views/                   # UI экраны
│   ├── Components/          # Переиспользуемые компоненты
│   ├── OnboardingView.swift
│   ├── HomeView.swift
│   └── ...
├── Services/                 # Сервисы и интеграции
│   ├── HealthKitService.swift
│   ├── CalendarService.swift
│   └── ...
├── Config/                  # Конфигурация
│   └── AppConfig.swift
└── Utilities/               # Утилиты
    └── Extensions.swift
```

## Дополнительные настройки

### Настройка подписки (StoreKit)

Для работы подписки необходимо:
1. Создать продукты в App Store Connect
2. Настроить идентификаторы продуктов в `SubscriptionService.swift`
3. Добавить тестовые аккаунты для тестирования

### Настройка уведомлений

Уведомления работают автоматически после запроса разрешения. Для тестирования:
1. Запустите приложение на устройстве
2. Разрешите уведомления
3. Установите время напоминания в настройках

## Следующие шаги

После успешного запуска:
1. Протестируйте онбординг
2. Проверьте выполнение челленджей
3. Убедитесь, что многоугольник прогресса отображается корректно
4. Протестируйте интеграции с HealthKit, Calendar, Reminders
5. Настройте систему подписки через App Store Connect

## Поддержка

При возникновении проблем проверьте:
- Версию Xcode (рекомендуется 14.0+)
- Версию iOS (16.0+)
- Правильность настройки всех capabilities
- Наличие всех необходимых разрешений в Info.plist

