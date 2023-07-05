//
//  LacoCalendarTests.swift
//  LacoCalendarTests
//
//  Created by Данил Терлецкий on 05.07.2023.
//

import XCTest
import RealmSwift
@testable import LacoCalendar

class LacoCalendarTests: XCTestCase {

    var realmService: MockRealmService!

    override func setUp() {
        super.setUp()

        realmService = MockRealmService()
    }

    func testSaveEvent() {
        let event = RealmEvent()
        event.name = "Test Event"
        event.dateStart = Date()

        realmService.save(event)

        let allEvents = realmService.getAllEvents()

        XCTAssertEqual(allEvents?.count, 1)
        XCTAssertEqual(allEvents?.first?.name, "Test Event")
    }

    func testUpdateEvent() {
        let event = RealmEvent()
        event.name = "Test Event"
        event.dateStart = Date()

        realmService.save(event)

        let updatedName = "Updated Event"
        let description = "Test description"
        let startDate = Date()
        let endDate = Date()

        realmService.update(event, with: updatedName, description: description, startDate: startDate, endDate: endDate)

        guard let allEvents = realmService.getAllEvents() else { return }

        XCTAssertEqual(allEvents.count, 1)
        XCTAssertEqual(allEvents.first?.name, updatedName)
    }

    func testDeleteEvent() {
        let event = RealmEvent()
        event.name = "Test Event"
        event.dateStart = Date()

        realmService.save(event)

        realmService.deleteEvent(event)

        guard let allEvents = realmService.getAllEvents() else { return }

        XCTAssertEqual(allEvents.count, 0)
    }

    override func tearDown() {
        super.tearDown()

        realmService.deleteAllEvents()
    }

}
