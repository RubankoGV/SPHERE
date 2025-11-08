//
//  Challenge.swift
//  SPHERE
//
//  Модель челленджа
//

import Foundation

enum ChallengeDifficulty: String, Codable, CaseIterable {
    case beginner = "Начинающий"
    case intermediate = "Средний"
    case advanced = "Продвинутый"
    case expert = "Эксперт"
    
    var xpReward: Int {
        switch self {
        case .beginner: return 10
        case .intermediate: return 25
        case .advanced: return 50
        case .expert: return 100
        }
    }
    
    var color: String {
        switch self {
        case .beginner: return "green"
        case .intermediate: return "blue"
        case .advanced: return "orange"
        case .expert: return "red"
        }
    }
}

struct Challenge: Identifiable, Codable {
    let id: UUID
    let sphere: LifeSphere
    let title: String
    let description: String
    let difficulty: ChallengeDifficulty
    let xpReward: Int
    let duration: Int // в днях
    let isDaily: Bool
    let isCompleted: Bool
    let completionDate: Date?
    let createdAt: Date
    
    init(
        id: UUID = UUID(),
        sphere: LifeSphere,
        title: String,
        description: String,
        difficulty: ChallengeDifficulty,
        duration: Int = 1,
        isDaily: Bool = false
    ) {
        self.id = id
        self.sphere = sphere
        self.title = title
        self.description = description
        self.difficulty = difficulty
        self.xpReward = difficulty.xpReward
        self.duration = duration
        self.isDaily = isDaily
        self.isCompleted = false
        self.completionDate = nil
        self.createdAt = Date()
    }
}

// Предустановленные челленджи для каждой сферы
struct ChallengeLibrary {
    static func getChallenges(for sphere: LifeSphere, userLevel: Int) -> [Challenge] {
        let difficulty = determineDifficulty(level: userLevel)
        
        switch sphere {
        case .health:
            return [
                Challenge(sphere: .health, title: "Выпить 2 литра воды", description: "Поддерживай водный баланс в течение дня", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .health, title: "8 часов сна", description: "Обеспечь себе полноценный отдых", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .health, title: "Утренняя зарядка 15 минут", description: "Начни день с лёгкой физической активности", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .health, title: "Медитация 10 минут", description: "Практикуй осознанность и расслабление", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .health, title: "Здоровый завтрак", description: "Приготовь питательный завтрак без фастфуда", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .health, title: "10,000 шагов", description: "Пройди рекомендованную норму шагов", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .health, title: "Без сахара день", description: "Исключи сладкое из рациона на день", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .health, title: "Витамины и добавки", description: "Прими рекомендованные витамины", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .health, title: "Контрастный душ", description: "Закаляйся и укрепляй иммунитет", difficulty: .advanced, isDaily: true),
                Challenge(sphere: .health, title: "Чекап здоровья", description: "Запишись на профилактический осмотр", difficulty: .expert, duration: 7),
                Challenge(sphere: .health, title: "Детокс неделя", description: "7 дней без вредной еды и алкоголя", difficulty: .expert, duration: 7),
                Challenge(sphere: .health, title: "Йога сессия", description: "Практикуй йогу для гибкости и силы", difficulty: .intermediate, isDaily: true)
            ]
            
        case .beauty:
            return [
                Challenge(sphere: .beauty, title: "Утренний уход за кожей", description: "Очищение, тонизирование, увлажнение", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .beauty, title: "Вечерний уход за кожей", description: "Полный ритуал перед сном", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .beauty, title: "Маска для лица", description: "Побалуй кожу питательной маской", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .beauty, title: "Укладка волос", description: "Создай аккуратный образ", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .beauty, title: "Маникюр/педикюр", description: "Уход за ногтями", difficulty: .intermediate, duration: 3),
                Challenge(sphere: .beauty, title: "Стрижка/бритьё", description: "Обновись и выгляди свежо", difficulty: .beginner, duration: 7),
                Challenge(sphere: .beauty, title: "SPF защита", description: "Используй солнцезащитный крем", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .beauty, title: "Ароматерапия", description: "Выбери свой аромат на день", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .beauty, title: "Массаж лица", description: "Самомассаж для тонуса кожи", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .beauty, title: "Обновление гардероба", description: "Выбери стильный образ", difficulty: .advanced, duration: 7),
                Challenge(sphere: .beauty, title: "Профессиональный уход", description: "Посети косметолога или барбера", difficulty: .expert, duration: 14),
                Challenge(sphere: .beauty, title: "Эксперимент с образом", description: "Попробуй новый стиль", difficulty: .advanced, duration: 7)
            ]
            
        case .study:
            return [
                Challenge(sphere: .study, title: "Читать 30 минут", description: "Изучай новую информацию каждый день", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .study, title: "Выучить 10 новых слов", description: "Расширяй словарный запас", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .study, title: "Просмотр образовательного видео", description: "30 минут полезного контента", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .study, title: "Конспект лекции", description: "Запиши и структурируй знания", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .study, title: "Практическое задание", description: "Примени теорию на практике", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .study, title: "Онлайн-курс урок", description: "Пройди один урок из курса", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .study, title: "Повторение материала", description: "Закрепи изученное ранее", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .study, title: "Изучение новой темы", description: "Погрузись в незнакомую область", difficulty: .advanced, isDaily: true),
                Challenge(sphere: .study, title: "Тест или экзамен", description: "Проверь свои знания", difficulty: .advanced, duration: 3),
                Challenge(sphere: .study, title: "Обучение других", description: "Объясни тему кому-то ещё", difficulty: .expert, isDaily: true),
                Challenge(sphere: .study, title: "Исследовательская работа", description: "Проведи мини-исследование", difficulty: .expert, duration: 7),
                Challenge(sphere: .study, title: "Языковая практика", description: "Практикуй иностранный язык", difficulty: .intermediate, isDaily: true)
            ]
            
        case .mentalHealth:
            return [
                Challenge(sphere: .mentalHealth, title: "Дневник благодарности", description: "Запиши 3 вещи, за которые благодарен", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .mentalHealth, title: "Медитация 15 минут", description: "Практикуй осознанность", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .mentalHealth, title: "Прогулка на природе", description: "Проведи время на свежем воздухе", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .mentalHealth, title: "Отключение от соцсетей", description: "2 часа без телефона", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .mentalHealth, title: "Разговор с близким", description: "Поделись мыслями с другом", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .mentalHealth, title: "Хобби время", description: "Посвяти час любимому делу", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .mentalHealth, title: "Арт-терапия", description: "Рисуй, лепи, твори", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .mentalHealth, title: "Дыхательные упражнения", description: "5 минут практики дыхания", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .mentalHealth, title: "Анализ эмоций", description: "Отследи свои чувства в течение дня", difficulty: .advanced, isDaily: true),
                Challenge(sphere: .mentalHealth, title: "Психолог сессия", description: "Запишись на консультацию", difficulty: .expert, duration: 14),
                Challenge(sphere: .mentalHealth, title: "Цифровой детокс день", description: "Полный день без гаджетов", difficulty: .expert, isDaily: true),
                Challenge(sphere: .mentalHealth, title: "Практика прощения", description: "Отпусти обиды и негатив", difficulty: .advanced, duration: 7)
            ]
            
        case .sport:
            return [
                Challenge(sphere: .sport, title: "Тренировка 30 минут", description: "Любая физическая активность", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .sport, title: "Силовая тренировка", description: "Работа с весом или собственным телом", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .sport, title: "Кардио сессия", description: "Бег, велосипед, плавание", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .sport, title: "Растяжка 20 минут", description: "Улучши гибкость", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .sport, title: "10,000 шагов", description: "Активный день", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .sport, title: "Утренняя пробежка", description: "Начни день с бега", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .sport, title: "Тренировка в зале", description: "Посещение фитнес-клуба", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .sport, title: "Йога или пилатес", description: "Практика гибкости и силы", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .sport, title: "Спортивная игра", description: "Футбол, баскетбол, теннис", difficulty: .advanced, isDaily: true),
                Challenge(sphere: .sport, title: "Интенсивная тренировка", description: "HIIT или кроссфит", difficulty: .expert, isDaily: true),
                Challenge(sphere: .sport, title: "Плавание", description: "Тренировка в бассейне", difficulty: .advanced, isDaily: true),
                Challenge(sphere: .sport, title: "Восстановительный день", description: "Лёгкая активность и растяжка", difficulty: .beginner, isDaily: true)
            ]
            
        case .personalLife:
            return [
                Challenge(sphere: .personalLife, title: "Время с близкими", description: "Качественное общение с семьёй/друзьями", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .personalLife, title: "Романтическое свидание", description: "Особенный вечер с партнёром", difficulty: .intermediate, duration: 3),
                Challenge(sphere: .personalLife, title: "Новое знакомство", description: "Познакомься с интересным человеком", difficulty: .advanced, duration: 7),
                Challenge(sphere: .personalLife, title: "Семейный ужин", description: "Проведи время с семьёй", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .personalLife, title: "Помощь другу", description: "Поддержи кого-то из окружения", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .personalLife, title: "Совместное хобби", description: "Занимайся любимым делом с кем-то", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .personalLife, title: "Глубокий разговор", description: "Откровенная беседа с близким", difficulty: .advanced, duration: 3),
                Challenge(sphere: .personalLife, title: "Сюрприз для любимого", description: "Порадуй партнёра неожиданным жестом", difficulty: .intermediate, duration: 7),
                Challenge(sphere: .personalLife, title: "Встреча с друзьями", description: "Социальная активность", difficulty: .beginner, duration: 3),
                Challenge(sphere: .personalLife, title: "Работа над отношениями", description: "Улучши качество общения", difficulty: .advanced, duration: 7),
                Challenge(sphere: .personalLife, title: "Семейное мероприятие", description: "Участие в семейном событии", difficulty: .intermediate, duration: 7),
                Challenge(sphere: .personalLife, title: "Благодарность близким", description: "Вырази признательность", difficulty: .beginner, isDaily: true)
            ]
            
        case .finances:
            return [
                Challenge(sphere: .finances, title: "Учёт расходов", description: "Запиши все траты за день", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .finances, title: "Отложить 10% дохода", description: "Создай финансовую подушку", difficulty: .intermediate, duration: 30),
                Challenge(sphere: .finances, title: "Без импульсивных покупок", description: "Контролируй спонтанные траты", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .finances, title: "Изучение финансов", description: "Читай о личных финансах 30 минут", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .finances, title: "Бюджет на месяц", description: "Составь план расходов", difficulty: .intermediate, duration: 7),
                Challenge(sphere: .finances, title: "Инвестиции исследование", description: "Изучи инвестиционные инструменты", difficulty: .advanced, duration: 7),
                Challenge(sphere: .finances, title: "Пересмотр подписок", description: "Отмени ненужные сервисы", difficulty: .beginner, duration: 7),
                Challenge(sphere: .finances, title: "Накопление цели", description: "Определи цель и начни копить", difficulty: .intermediate, duration: 30),
                Challenge(sphere: .finances, title: "Финансовый план", description: "Стратегия на год", difficulty: .expert, duration: 14),
                Challenge(sphere: .finances, title: "Консультация с экспертом", description: "Встреча с финансовым советником", difficulty: .expert, duration: 30),
                Challenge(sphere: .finances, title: "Пассивный доход", description: "Изучи возможности пассивного дохода", difficulty: .advanced, duration: 14),
                Challenge(sphere: .finances, title: "Экономия на покупках", description: "Используй скидки и кэшбэк", difficulty: .beginner, isDaily: true)
            ]
            
        case .selfDevelopment:
            return [
                Challenge(sphere: .selfDevelopment, title: "Чтение 30 минут", description: "Развивающая литература", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .selfDevelopment, title: "Подкаст или аудиокнига", description: "Слушай полезный контент", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .selfDevelopment, title: "Новый навык", description: "Начни изучать что-то новое", difficulty: .intermediate, duration: 7),
                Challenge(sphere: .selfDevelopment, title: "Саморефлексия", description: "Анализ своих действий и результатов", difficulty: .advanced, isDaily: true),
                Challenge(sphere: .selfDevelopment, title: "Выход из зоны комфорта", description: "Сделай что-то необычное", difficulty: .advanced, isDaily: true),
                Challenge(sphere: .selfDevelopment, title: "Менторство", description: "Найди наставника или стань им", difficulty: .expert, duration: 30),
                Challenge(sphere: .selfDevelopment, title: "Личный бренд", description: "Работа над своим образом", difficulty: .advanced, duration: 14),
                Challenge(sphere: .selfDevelopment, title: "Публичное выступление", description: "Поделись знаниями с аудиторией", difficulty: .expert, duration: 14),
                Challenge(sphere: .selfDevelopment, title: "Сертификация", description: "Получи новый сертификат", difficulty: .expert, duration: 30),
                Challenge(sphere: .selfDevelopment, title: "Творческий проект", description: "Создай что-то новое", difficulty: .intermediate, duration: 7),
                Challenge(sphere: .selfDevelopment, title: "Волонтёрство", description: "Помоги другим", difficulty: .advanced, duration: 7),
                Challenge(sphere: .selfDevelopment, title: "Журнал развития", description: "Веди записи о прогрессе", difficulty: .intermediate, isDaily: true)
            ]
            
        case .purpose:
            return [
                Challenge(sphere: .purpose, title: "Постановка цели", description: "Определи одну важную цель", difficulty: .beginner, duration: 7),
                Challenge(sphere: .purpose, title: "План действий", description: "Разбей цель на шаги", difficulty: .intermediate, duration: 7),
                Challenge(sphere: .purpose, title: "Шаг к цели", description: "Выполни один шаг из плана", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .purpose, title: "Визуализация цели", description: "Представь результат", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .purpose, title: "Миссия жизни", description: "Определи свою миссию", difficulty: .expert, duration: 14),
                Challenge(sphere: .purpose, title: "Ценности анализ", description: "Определи свои ценности", difficulty: .advanced, duration: 7),
                Challenge(sphere: .purpose, title: "Долгосрочное планирование", description: "План на 5 лет", difficulty: .expert, duration: 30),
                Challenge(sphere: .purpose, title: "Еженедельный обзор", description: "Оцени прогресс за неделю", difficulty: .intermediate, duration: 7),
                Challenge(sphere: .purpose, title: "Мотивационная цитата", description: "Найди вдохновение", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .purpose, title: "Препятствия анализ", description: "Определи и преодолей барьеры", difficulty: .advanced, duration: 7),
                Challenge(sphere: .purpose, title: "Достижение цели", description: "Заверши одну цель", difficulty: .expert, duration: 30),
                Challenge(sphere: .purpose, title: "Новая цель", description: "Поставь следующую цель", difficulty: .intermediate, duration: 7)
            ]
            
        case .productivity:
            return [
                Challenge(sphere: .productivity, title: "План дня", description: "Составь список задач на день", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .productivity, title: "Завершить 3 важные задачи", description: "Сфокусируйся на приоритетах", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .productivity, title: "Техника Pomodoro", description: "4 сессии по 25 минут", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .productivity, title: "Утренний ритуал", description: "Начни день продуктивно", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .productivity, title: "Без отвлечений 2 часа", description: "Глубокая работа", difficulty: .advanced, isDaily: true),
                Challenge(sphere: .productivity, title: "Inbox Zero", description: "Разбери все сообщения", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .productivity, title: "Автоматизация задачи", description: "Оптимизируй повторяющийся процесс", difficulty: .advanced, duration: 7),
                Challenge(sphere: .productivity, title: "Делегирование", description: "Передай задачу другому", difficulty: .advanced, duration: 7),
                Challenge(sphere: .productivity, title: "Еженедельный обзор", description: "Анализ и планирование недели", difficulty: .intermediate, duration: 7),
                Challenge(sphere: .productivity, title: "Система организации", description: "Создай свою систему", difficulty: .expert, duration: 14),
                Challenge(sphere: .productivity, title: "Энергия управление", description: "Распредели задачи по энергии", difficulty: .advanced, duration: 7),
                Challenge(sphere: .productivity, title: "Завершить проект", description: "Доведи дело до конца", difficulty: .expert, duration: 30)
            ]
            
        case .career:
            return [
                Challenge(sphere: .career, title: "Профессиональное обучение", description: "Изучи новую тему в своей области", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .career, title: "Сеть контактов", description: "Новое профессиональное знакомство", difficulty: .advanced, duration: 7),
                Challenge(sphere: .career, title: "Обновление резюме", description: "Актуализируй свой профиль", difficulty: .intermediate, duration: 7),
                Challenge(sphere: .career, title: "Проект портфолио", description: "Добавь новую работу", difficulty: .advanced, duration: 14),
                Challenge(sphere: .career, title: "Профессиональная встреча", description: "Конференция или митап", difficulty: .advanced, duration: 14),
                Challenge(sphere: .career, title: "Наставничество", description: "Стань ментором или найди его", difficulty: .expert, duration: 30),
                Challenge(sphere: .career, title: "Новый навык для карьеры", description: "Изучи инструмент или технологию", difficulty: .intermediate, duration: 14),
                Challenge(sphere: .career, title: "Обратная связь", description: "Получи фидбек от коллег", difficulty: .advanced, duration: 7),
                Challenge(sphere: .career, title: "Карьерная цель", description: "Определи следующий шаг", difficulty: .intermediate, duration: 7),
                Challenge(sphere: .career, title: "Лидерский проект", description: "Возглавь инициативу", difficulty: .expert, duration: 30),
                Challenge(sphere: .career, title: "Публикация контента", description: "Поделись экспертизой", difficulty: .advanced, duration: 7),
                Challenge(sphere: .career, title: "Переговоры", description: "Улучши условия работы", difficulty: .expert, duration: 30)
            ]
            
        case .communication:
            return [
                Challenge(sphere: .communication, title: "Активное слушание", description: "Полностью присутствуй в разговоре", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .communication, title: "Новое знакомство", description: "Познакомься с интересным человеком", difficulty: .advanced, duration: 7),
                Challenge(sphere: .communication, title: "Публичное выступление", description: "Выступи перед аудиторией", difficulty: .expert, duration: 14),
                Challenge(sphere: .communication, title: "Конструктивная обратная связь", description: "Дай полезный фидбек", difficulty: .advanced, duration: 7),
                Challenge(sphere: .communication, title: "Сложный разговор", description: "Обсуди важную тему", difficulty: .expert, duration: 7),
                Challenge(sphere: .communication, title: "Сеть контактов", description: "Расширь профессиональную сеть", difficulty: .advanced, duration: 14),
                Challenge(sphere: .communication, title: "Эмпатия практика", description: "Поставь себя на место другого", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .communication, title: "Язык тела", description: "Обрати внимание на невербальное", difficulty: .advanced, duration: 7),
                Challenge(sphere: .communication, title: "Презентация навыков", description: "Расскажи о своих достижениях", difficulty: .intermediate, duration: 7),
                Challenge(sphere: .communication, title: "Межкультурное общение", description: "Взаимодействие с другой культурой", difficulty: .expert, duration: 14),
                Challenge(sphere: .communication, title: "Медиация конфликта", description: "Помоги разрешить спор", difficulty: .expert, duration: 14),
                Challenge(sphere: .communication, title: "Благодарность выражение", description: "Вырази признательность", difficulty: .beginner, isDaily: true)
            ]
            
        case .organization:
            return [
                Challenge(sphere: .organization, title: "Уборка рабочего места", description: "Наведи порядок на столе", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .organization, title: "Цифровая организация", description: "Разбери файлы и папки", difficulty: .intermediate, duration: 7),
                Challenge(sphere: .organization, title: "План недели", description: "Структурируй предстоящую неделю", difficulty: .beginner, duration: 7),
                Challenge(sphere: .organization, title: "Система хранения", description: "Создай удобную систему", difficulty: .intermediate, duration: 7),
                Challenge(sphere: .organization, title: "Минимализм день", description: "Избавься от лишнего", difficulty: .advanced, isDaily: true),
                Challenge(sphere: .organization, title: "Календарь синхронизация", description: "Обнови все события", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .organization, title: "Чек-лист проекта", description: "Создай план выполнения", difficulty: .intermediate, duration: 7),
                Challenge(sphere: .organization, title: "Архив старых данных", description: "Организуй архив", difficulty: .advanced, duration: 14),
                Challenge(sphere: .organization, title: "Автоматизация рутины", description: "Настрой автоматические процессы", difficulty: .expert, duration: 14),
                Challenge(sphere: .organization, title: "Зона комфорта организация", description: "Организуй пространство вокруг", difficulty: .intermediate, duration: 7),
                Challenge(sphere: .organization, title: "Система напоминаний", description: "Настрой уведомления", difficulty: .beginner, duration: 7),
                Challenge(sphere: .organization, title: "Ежемесячный обзор", description: "Анализ и оптимизация систем", difficulty: .advanced, duration: 30)
            ]
            
        case .discipline:
            return [
                Challenge(sphere: .discipline, title: "Ранний подъём", description: "Проснись в запланированное время", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .discipline, title: "Утренний ритуал", description: "Выполни все утренние задачи", difficulty: .beginner, isDaily: true),
                Challenge(sphere: .discipline, title: "Отложить удовольствие", description: "Сначала важное, потом приятное", difficulty: .advanced, isDaily: true),
                Challenge(sphere: .discipline, title: "Следовать плану", description: "Выполни все запланированное", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .discipline, title: "Без оправданий", description: "Выполни задачу без откладывания", difficulty: .advanced, isDaily: true),
                Challenge(sphere: .discipline, title: "Контроль времени", description: "Следуй расписанию", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .discipline, title: "Преодоление лени", description: "Действуй несмотря на нежелание", difficulty: .expert, isDaily: true),
                Challenge(sphere: .discipline, title: "Последовательность", description: "Не пропускай дни", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .discipline, title: "Самоконтроль", description: "Контролируй импульсы", difficulty: .advanced, isDaily: true),
                Challenge(sphere: .discipline, title: "Долгосрочная привычка", description: "30 дней подряд", difficulty: .expert, duration: 30),
                Challenge(sphere: .discipline, title: "Ответственность", description: "Выполни обещание себе", difficulty: .intermediate, isDaily: true),
                Challenge(sphere: .discipline, title: "Сила воли тренировка", description: "Сделай сложное дело", difficulty: .expert, isDaily: true)
            ]
        }
    }
    
    private static func determineDifficulty(level: Int) -> ChallengeDifficulty {
        switch level {
        case 1...5: return .beginner
        case 6...15: return .intermediate
        case 16...30: return .advanced
        default: return .expert
        }
    }
}

