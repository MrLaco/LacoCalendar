//
//  CreateEventViewController.swift
//  LacoCalendar
//
//  Created by Данил Терлецкий on 03.07.2023.
//

import UIKit
import SnapKit
import Macaroni

class CreateEventViewController: UIViewController {

    @Injected(.lazily)
    private var realmService: RealmServiceProtocol

    var calendarViewController: CalendarViewController
    var calendarWrapper: CalendarWrapper

    private var name: String?
    private var startDate: Date
    private var endDate: Date
    private var descriptionText: String?

    init(calendarViewController: CalendarViewController) {
        self.calendarViewController = calendarViewController
        self.calendarWrapper = CalendarWrapper(realmEvent: RealmEvent())
        self.startDate = Date()
        self.endDate = Date()

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
        title = "Событие"

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

        let saveButton = UIBarButtonItem(title: "Добавить",
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
        guard let eventName = name else {
            let alertController = UIAlertController(title: "Ошибка =(",
                                                    message: "Название события не может быть пустым!",
                                                    preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .cancel)
            alertController.addAction(alertAction)

            present(alertController, animated: true)
            return
        }

        let eventDescription = descriptionText
        let startDate = startDate
        let endDate = endDate

        self.calendarWrapper = CalendarWrapper(realmEvent: RealmEvent())
        self.calendarWrapper.text = eventName
        self.calendarWrapper.description = eventDescription ?? ""
        self.calendarWrapper.dateInterval = DateInterval(start: startDate, end: endDate)

        let newEvent = calendarWrapper.realmEvent
        realmService.save(newEvent)

        calendarViewController.reloadData()
        dismiss(animated: true)
    }
}

extension CreateEventViewController: EventTableViewDelegate {
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
