//
//  DescriptionCell.swift
//  LacoCalendar
//
//  Created by Данил Терлецкий on 03.07.2023.
//

import UIKit
import SnapKit

class DescriptionCell: UITableViewCell {

    weak var delegate: EventTableViewDelegate?

    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.autocorrectionType = .no
        textView.font = .systemFont(ofSize: 16)
        textView.delegate = self
        return textView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(descriptionTextView)

        descriptionTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-394)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DescriptionCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let newDescription = textView.text {
            delegate?.descriptionDidChange(newDescription)
        }
    }
}
