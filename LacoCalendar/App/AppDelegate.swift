//
//  AppDelegate.swift
//  LacoCalendar
//
//  Created by Данил Терлецкий on 29.06.2023.
//

import UIKit
import Macaroni

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    @Injected(.lazily)
    var realmService: RealmServiceProtocol

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let calendarVC = CalendarViewController()
        let navigationVC = UINavigationController(rootViewController: calendarVC)

        let configurator = Configurator()
        configurator.configure()

        realmService.loadMockData()

        window.rootViewController = navigationVC
        window.makeKeyAndVisible()

        return true
    }
}
