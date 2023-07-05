//
//  CalendarViewController.swift
//  LacoCalendar
//
//  Created by Данил Терлецкий on 29.06.2023.
//

import UIKit
import CalendarKit
import EventKit
import EventKitUI
import Macaroni

class CalendarViewController: DayViewController {

    @Injected(.lazily)
    private var realmService: RealmServiceProtocol

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Ежедневник"
        setupNavigationButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setToolbarHidden(true, animated: false)
    }

    // MARK: - Setup methods

    private func setupNavigationButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(addButtonDidTap))
        addButton.tintColor = .systemRed
        navigationItem.rightBarButtonItem = addButton
    }

    @objc private func addButtonDidTap() {
        let createEventVC = CreateEventViewController(calendarViewController: self)
        let navigationController = UINavigationController(rootViewController: createEventVC)
        present(navigationController, animated: true)
    }

//    func createTestData() {
//        let newCalendar = Calendar.current
//
//        let date = Date()
//        var oneHourComponents = DateComponents()
//        oneHourComponents.hour = 1
//        let endDate = newCalendar.date(byAdding: oneHourComponents, to: date)!
//
//        let event = RealmEvent(dateStart: date, dateFinish: endDate, name: "BIG EVENT", descriptionText: "BOMBA DESC")
//        realmService.save(event)
//    }

    override func eventsForDate(_ date: Date) -> [EventDescriptor] {

        let startDate = date
        var oneDayComponents = DateComponents()
        oneDayComponents.day = 1

        guard
            let endDate = calendar.date(byAdding: oneDayComponents, to: startDate),
            let realmEvents = realmService.getEvents(for: startDate, and: endDate)
        else {
            return []
        }
        let calendarKitEvents = realmEvents.map(CalendarWrapper.init)
        return calendarKitEvents
    }

    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard
            let ckEvent = eventView.descriptor as? CalendarWrapper
        else {
            return
        }
        presentDetailedView(ckEvent)
    }

    private func presentDetailedView(_ ckEvent: CalendarWrapper) {
        guard
            let eventDetailsVC = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "EventDetailsViewController")
                as? EventDetailsViewController
        else { return }
        eventDetailsVC.calendarWrapper = ckEvent
        eventDetailsVC.calendarViewController = self
        navigationController?.pushViewController(eventDetailsVC, animated: true)
    }
}
