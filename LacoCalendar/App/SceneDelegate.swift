//
//  SceneDelegate.swift
//  LacoCalendar
//
//  Created by Данил Терлецкий on 29.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window

        let calendarVC = CalendarViewController()
        let navigationVC = UINavigationController(rootViewController: calendarVC)

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = nil
        appearance.backgroundColor = .white

        let navigationBar = navigationVC.navigationBar
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance

        let configurator = Configurator()
        configurator.configure()

        window.rootViewController = navigationVC
        window.makeKeyAndVisible()
    }
}
