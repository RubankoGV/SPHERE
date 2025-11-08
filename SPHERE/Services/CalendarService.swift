//
//  CalendarService.swift
//  SPHERE
//
//  Интеграция с Calendar
//

import Foundation
import EventKit

class CalendarService: ObservableObject {
    private let eventStore = EKEventStore()
    
    func requestAccess(completion: @escaping (Bool) -> Void) {
        eventStore.requestAccess(to: .event) { granted, error in
            if let error = error {
                print("Ошибка доступа к календарю: \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(granted)
        }
    }
    
    func createEvent(
        title: String,
        startDate: Date,
        endDate: Date,
        notes: String? = nil
    ) -> Bool {
        let event = EKEvent(eventStore: eventStore)
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.notes = notes
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        do {
            try eventStore.save(event, span: .thisEvent)
            return true
        } catch {
            print("Ошибка создания события: \(error.localizedDescription)")
            return false
        }
    }
    
    func getTodayEvents(completion: @escaping ([EKEvent]) -> Void) {
        let startDate = Calendar.current.startOfDay(for: Date())
        let endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
        
        let predicate = eventStore.predicateForEvents(
            withStart: startDate,
            end: endDate,
            calendars: nil
        )
        
        let events = eventStore.events(matching: predicate)
        completion(events)
    }
}

