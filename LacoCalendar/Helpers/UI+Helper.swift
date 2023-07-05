//
//  UI+Helper.swift
//  LacoCalendar
//
//  Created by Данил Терлецкий on 03.07.2023.
//

import UIKit

public func addSubviews(for view: UIView, subviews: UIView...) {
    subviews.forEach { view.addSubview($0) }
}

public func addSubviews(for view: UIStackView, subviews: UIView...) {
    subviews.forEach { view.addArrangedSubview($0) }
}
