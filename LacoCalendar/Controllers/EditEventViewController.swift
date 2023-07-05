//
//  TestEditEventViewController.swift
//  LacoCalendar
//
//  Created by Данил Терлецкий on 03.07.2023.
//

import UIKit
import SnapKit
import Macaroni

class EditEventViewController: UIViewController {

    @Injected(.lazily)
    private var realmService: RealmServiceProtocol

    var calendarWrapper: CalendarWrapper
    var eventDetailsViewController: EventDetailsViewController
    var calendarViewController: CalendarViewController

    private var name: String
    private var startDate: Date
    private var endDate: Date
    private var descriptionText: String

    init(calendarWrapper: CalendarWrapper,
         eventDetailsViewController: EventDetailsViewController,
         calendarViewController: CalendarViewController) {
        self.calendarWrapper = calendarWrapper
        self.eventDetailsViewController = eventDetailsViewController
        self.calendarViewController = calendarViewController
        self.name = calendarWrapper.text
        self.startDate = calendarWrapper.dateInterval.start
        self.endDate = calendarWrapper.dateInterval.end
        self.descriptionText = calendarWrapper.description

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LyfeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        setupNavigationButtons()
    }

    // MARK: - UI

    private lazy var tableView: EventTableView = {
        return EventTableView(calendarWrapper: calendarWrapper)
    }()

    // MARK: - Methods

    private func setupUI() {
        view.backgroundColor = .white
        title = "Правка"

        tableView.eventDelegate = self
    }

    private func setupConstraints() {
        addSubviews(
            for: view,
            subviews: tableView
        )

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupNavigationButtons() {
        navigationController?.navigationBar.isHidden = false

        let cancelButton = UIBarButtonItem(title: "Отменить",
                                         style: .plain,
                                         target: self,
                                         action: #selector(cancelButtonTapped))
        cancelButton.tintColor = .systemRed

        let saveButton = UIBarButtonItem(title: "Готово",
                                         style: .done,
                                         target: self,
                                         action: #selector(saveButtonDidTap))
        saveButton.tintColor = .systemRed

        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton

    }

    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }

    @objc func saveButtonDidTap() {
        let event = calendarWrapper.realmEvent

        let eventName = name
        let eventDescription = descriptionText
        let startDate = startDate
        let endDate = endDate

        realmService.update(event,
                            with: eventName,
                            description: eventDescription,
                            startDate: startDate,
                            endDate: endDate)

        eventDetailsViewController.updateUI()
        calendarViewController.reloadData()

        dismiss(animated: true)
    }
}

extension EditEventViewController: EventTableViewDelegate {
    func nameDidChange(_ newName: String) {
        self.name = newName
    }

    func startDateDidChange(_ newStartDate: Date) {
        self.startDate = newStartDate
    }

    func endDateDidChange(_ newEndDate: Date) {
        self.endDate = newEndDate
    }

    func descriptionDidChange(_ newDescription: String) {
        self.descriptionText = newDescription
    }
}
