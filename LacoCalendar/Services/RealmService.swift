//
//  RealmService.swift
//  LacoCalendar
//
//  Created by Данил Терлецкий on 02.07.2023.
//

import Foundation
import RealmSwift

protocol RealmServiceProtocol {

    func getAllEvents() -> [RealmEvent]?
    func getEvents(for startDate: Date, and finishDate: Date) -> [RealmEvent]?
    func save(_ event: RealmEvent)
    func update(_ event: RealmEvent, with name: String, description: String, startDate: Date, endDate: Date)
    func deleteAllEvents()
    func deleteEvent(_ event: RealmEvent)
}

class RealmService: RealmServiceProtocol {

    func getAllEvents() -> [RealmEvent]? {
        var results: [RealmEvent]?
        do {
            let realm = try Realm()
            results = Array(realm.objects(RealmEvent.self))
            realm.refresh()
        } catch {
            print("Error. Failed to fetch all events from Realm: " + error.localizedDescription)
        }
        return results
    }

    func getEvents(for startDate: Date, and finishDate: Date) -> [RealmEvent]? {
        var results: [RealmEvent]?
        do {
            let realm = try Realm()
            results = Array(realm.objects(RealmEvent.self)
                .filter("dateStart >= %@ AND dateStart < %@", startDate, finishDate))
            realm.refresh()
        } catch {
            print("Error. Failed to fetch events for startDate and endDate from Realm: " + error.localizedDescription)
        }
        return results
    }

    func save(_ event: RealmEvent) {
        do {
            let realm = try Realm()
            if realm.object(ofType: RealmEvent.self, forPrimaryKey: event.id) != nil {
                event.id = UUID().uuidString
            }
            try realm.write {
                realm.add(event)
                realm.refresh()
            }
        } catch {
            print("Error. Failed to save event to Realm: " + error.localizedDescription)
        }
    }

    func update(_ event: RealmEvent, with name: String, description: String, startDate: Date, endDate: Date) {
        do {
            let realm = try Realm()
            try realm.write {
                event.name = name
                event.descriptionText = description
                event.dateStart = startDate
                event.dateFinish = endDate
            }
        } catch {
            print("Error. Failed to update event in Realm: \(error.localizedDescription)")
        }
    }

    func deleteAllEvents() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Error. Failed to delete all events from Realm: \(error.localizedDescription)")
        }

    }

    func deleteEvent(_ event: RealmEvent) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(event)
            }
        } catch {
            print("Error. Failed to delete event from Realm: \(error.localizedDescription)")
        }
    }
}
