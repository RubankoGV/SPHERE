//
//  RemindersService.swift
//  SPHERE
//
//  Интеграция с Reminders
//

import Foundation
import EventKit

class RemindersService: ObservableObject {
    private let eventStore = EKEventStore()
    
    func requestAccess(completion: @escaping (Bool) -> Void) {
        eventStore.requestAccess(to: .reminder) { granted, error in
            if let error = error {
                print("Ошибка доступа к напоминаниям: \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(granted)
        }
    }
    
    func createReminder(
        title: String,
        dueDate: Date? = nil,
        notes: String? = nil
    ) -> Bool {
        let reminder = EKReminder(eventStore: eventStore)
        reminder.title = title
        reminder.notes = notes
        reminder.dueDateComponents = dueDate.map {
            Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: $0)
        }
        reminder.calendar = eventStore.defaultCalendarForNewReminders
        
        do {
            try eventStore.save(reminder, commit: true)
            return true
        } catch {
            print("Ошибка создания напоминания: \(error.localizedDescription)")
            return false
        }
    }
    
    func getTodayReminders(completion: @escaping ([EKReminder]) -> Void) {
        let predicate = eventStore.predicateForReminders(in: nil)
        eventStore.fetchReminders(matching: predicate) { reminders in
            guard let reminders = reminders else {
                completion([])
                return
            }
            
            let today = Calendar.current.startOfDay(for: Date())
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
            
            let todayReminders = reminders.filter { reminder in
                guard let dueDate = reminder.dueDateComponents?.date else { return false }
                return dueDate >= today && dueDate < tomorrow
            }
            
            completion(todayReminders)
        }
    }
}

