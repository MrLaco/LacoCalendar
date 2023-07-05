//
//  StartDateCell.swift
//  LacoCalendar
//
//  Created by Данил Терлецкий on 03.07.2023.
//

import UIKit
import SnapKit

class StartDateCell: UITableViewCell {

    weak var delegate: EventTableViewDelegate?

    lazy var startDatelabel: UILabel = {
        let label = UILabel()
        label.text = "Начало"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(self, action: #selector(datePickerDidChange), for: .valueChanged)
        return datePicker
    }()

    @objc private func datePickerDidChange(_ datePicker: UIDatePicker) {
        let newStartDate = datePicker.date

        delegate?.startDateDidChange(newStartDate)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(startDatelabel)
        contentView.addSubview(datePicker)

        startDatelabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }

        datePicker.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
