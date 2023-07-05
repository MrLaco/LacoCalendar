//
//  Configurator.swift
//  LacoCalendar
//
//  Created by Данил Терлецкий on 05.07.2023.
//

import Foundation
import Macaroni

class Configurator {

    func configure() {
        Macaroni.logger = DisabledMacaroniLogger()
        let container = Container()
        Container.lookupPolicy = .singleton(container)

        let realmService = RealmService()
        container.register { () -> RealmServiceProtocol in
            realmService
        }
    }
}
