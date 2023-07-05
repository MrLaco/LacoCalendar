//
//  EventCell.swift
//  LacoCalendar
//
//  Created by Данил Терлецкий on 03.07.2023.
//

import UIKit
import SnapKit

class NameCell: UITableViewCell, UITextFieldDelegate {

    weak var delegate: EventTableViewDelegate?

    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите название события"
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()

    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let newText = textField.text {
            delegate?.nameDidChange(newText)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(nameTextField)

        nameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
