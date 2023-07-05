//
//  EventTableView.swift
//  LacoCalendar
//
//  Created by Данил Терлецкий on 03.07.2023.
//

import UIKit
import SnapKit

enum CellIdentifier: String {
    case nameCell
    case startDateCell
    case endDateCell
    case descriptionCell
}

protocol EventTableViewDelegate: AnyObject {
    func nameDidChange(_ newName: String)
    func startDateDidChange(_ newStartDate: Date)
    func endDateDidChange(_ newEndDate: Date)
    func descriptionDidChange(_ newDescription: String)
}

class EventTableView: UITableView {

    weak var eventDelegate: EventTableViewDelegate?

    var calendarWrapper: CalendarWrapper

    init(calendarWrapper: CalendarWrapper) {
        self.calendarWrapper = calendarWrapper

        if #available(iOS 13.0, *) {
            super.init(frame: .zero, style: .insetGrouped)
        } else {
            super.init(frame: .zero, style: .plain)
        }

        register(NameCell.self, forCellReuseIdentifier: CellIdentifier.nameCell.rawValue)
        register(StartDateCell.self, forCellReuseIdentifier: CellIdentifier.startDateCell.rawValue)
        register(EndDateCell.self, forCellReuseIdentifier: CellIdentifier.endDateCell.rawValue)
        register(DescriptionCell.self, forCellReuseIdentifier: CellIdentifier.descriptionCell.rawValue)

        dataSource = self
        delegate = self
        separatorStyle = .singleLine
        allowsSelection = false
        tableFooterView = UIView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EventTableView: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.nameCell.rawValue,
                                                         for: indexPath)
                    as? NameCell
            else { return UITableViewCell() }
            cell.delegate = eventDelegate
            cell.nameTextField.text = calendarWrapper.text
            return cell
        case 1:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.startDateCell.rawValue,
                                                         for: indexPath) as? StartDateCell
            else { return UITableViewCell() }
            cell.delegate = eventDelegate
            cell.datePicker.date = calendarWrapper.dateInterval.start
            return cell
        case 2:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.endDateCell.rawValue,
                                                         for: indexPath) as? EndDateCell
            else { return UITableViewCell() }
            cell.delegate = eventDelegate
            cell.datePicker.date = calendarWrapper.dateInterval.end
            return cell
        case 3:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.descriptionCell.rawValue,
                                                         for: indexPath) as? DescriptionCell
                else { return UITableViewCell() }
            cell.delegate = eventDelegate
            cell.descriptionTextView.text = calendarWrapper.description
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
