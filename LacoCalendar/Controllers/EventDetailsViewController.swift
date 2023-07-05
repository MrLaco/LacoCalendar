//
//  SBDetailsViewController.swift
//  LacoCalendar
//
//  Created by Данил Терлецкий on 03.07.2023.
//

import UIKit
import Macaroni

class EventDetailsViewController: UIViewController {

    @Injected(.lazily)
    private var realmService: RealmServiceProtocol

    var calendarWrapper: CalendarWrapper?
    var calendarViewController: CalendarViewController?

    // MARK: - IB Outlets

    @IBOutlet
    private weak var nameLabel: UILabel!

    @IBOutlet
    private weak var descriptionLabel: UILabel!

    @IBOutlet
    private weak var timeLabel: UILabel!

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupNavigationButton()
    }

    // MARK: - UI

    private func setupUI() {
        title = "Подробнее"

        setupNameLabel()
        setupTimeLabel()
        setupDescriptionLabel()
    }

    func updateUI() {
        setupNameLabel()
        setupTimeLabel()
        setupDescriptionLabel()
    }

    private func setupNavigationButton() {
        let editButton = UIBarButtonItem(title: "Править",
                                         style: .plain,
                                         target: self,
                                         action: #selector(editButtonTapped))
        editButton.tintColor = .systemRed
        navigationItem.rightBarButtonItem = editButton
    }

    @objc func editButtonTapped() {
        guard let calendarWrapper, let calendarViewController else { return }
        let editEventVC = EditEventViewController(calendarWrapper: calendarWrapper,
                                                  eventDetailsViewController: self,
                                                  calendarViewController: calendarViewController)
        let navigationController = UINavigationController(rootViewController: editEventVC)
        present(navigationController, animated: true)

    }

    private func setupNameLabel() {
        guard let calendarWrapper else { return }

        nameLabel.text = calendarWrapper.text
    }

    private func setupDescriptionLabel() {
        guard let calendarWrapper else { return }

        descriptionLabel.text = calendarWrapper.description
    }

    private func setupTimeLabel() {
        guard let calendarWrapper else { return }

        nameLabel.text = calendarWrapper.text
        descriptionLabel.text = calendarWrapper.description

        let dateInterval = calendarWrapper.dateInterval

        timeLabel.text = prepareTimeLabel(from: dateInterval)
    }

    private func prepareTimeLabel(from dateInterval: DateInterval) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "EEEE, dd MMMM yyyy 'г.'"
        let startDateString = dateFormatter.string(from: dateInterval.start)

        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale(identifier: "ru_RU")
        timeFormatter.dateFormat = "HH:mm"

        let startTimeString = timeFormatter.string(from: dateInterval.start)
        let endTimeString = timeFormatter.string(from: dateInterval.end)

        return "\(startDateString)" + "\n" + "с \(startTimeString) до \(endTimeString)"
    }

    // MARK: - Actions
    @IBAction
    private func deleteThisEvent() {
        guard let event = calendarWrapper?.realmEvent else { return }

        realmService.deleteEvent(event)
        navigationController?.popViewController(animated: true)

        calendarViewController?.reloadData()
    }

}
