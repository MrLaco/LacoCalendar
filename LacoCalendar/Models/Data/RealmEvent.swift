//
//  RealmEvent.swift
//  LacoCalendar
//
//  Created by Данил Терлецкий on 02.07.2023.
//

import RealmSwift
import Foundation

public class RealmEvent: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var dateStart: Date
    @Persisted var dateFinish: Date
    @Persisted var name: String
    @Persisted var descriptionText: String?

    convenience init(dateStart: Date, dateFinish: Date, name: String, descriptionText: String? = nil) {
        self.init()
        self.id = UUID().uuidString
        self.dateStart = dateStart
        self.dateFinish = dateFinish
        self.name = name
        self.descriptionText = descriptionText
    }
}
