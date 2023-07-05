//
//  EKWrapper.swift
//  LacoCalendar
//
//  Created by Данил Терлецкий on 01.07.2023.
//

import UIKit
import CalendarKit
import EventKit

public final class CalendarWrapper: EventDescriptor {

    public private(set) var realmEvent: RealmEvent

    init(realmEvent: RealmEvent) {
        self.realmEvent = realmEvent
    }

    public var dateInterval: DateInterval {
        get {
            DateInterval(start: realmEvent.dateStart, end: realmEvent.dateFinish)
        }
        set {
            realmEvent.dateStart = newValue.start
            realmEvent.dateFinish = newValue.end
        }
    }

    public var isAllDay: Bool = false

    public var text: String {
        get {
            realmEvent.name
        }
        set {
            realmEvent.name = newValue
        }
    }

    public var description: String {
        get {
            realmEvent.descriptionText ?? ""
        }
        set {
            realmEvent.descriptionText = newValue
        }
    }

    public var attributedText: NSAttributedString?
    public var lineBreakMode: NSLineBreakMode?

    public var font: UIFont = UIFont.boldSystemFont(ofSize: 12)

    public var color: UIColor {
        UIColor.blue
    }

    public var textColor: UIColor = SystemColors.label
    public var backgroundColor: UIColor = UIColor.init(red: 204 / 255, green: 204 / 255, blue: 255 / 255, alpha: 1)

    public var editedEvent: CalendarKit.EventDescriptor?

    public func makeEditable() -> Self {
        let cloned = Self(realmEvent: realmEvent)
        cloned.editedEvent = self
        return cloned
    }

    public func commitEditing() {
        guard let edited = editedEvent else { return }
        edited.dateInterval = dateInterval
    }
}
