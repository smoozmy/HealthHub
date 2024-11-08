//
//  SceneDelegate.swift
//  HealthHub
//
//  Created by Александр Крапивин on 02.11.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
                
                if isLoggedIn {
                    let profileVC = ProfileViewController()
                    window?.rootViewController = profileVC
                } else {
                    let welcomeVC = WelcomeViewController()
                    window?.rootViewController = welcomeVC
                }
//        window?.rootViewController = UINavigationController(rootViewController: WelcomeViewController())
        window?.makeKeyAndVisible()
    }
}

