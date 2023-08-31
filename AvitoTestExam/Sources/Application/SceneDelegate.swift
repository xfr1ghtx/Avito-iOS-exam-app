//
//  SceneDelegate.swift
//  AvitoTestExam
//
//  Created by Степан Потапов on 25.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var mainCoordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        mainCoordinator = createMainCoordinator(withScene: windowScene)
        mainCoordinator?.start(animated: false)
    }
    
    private func createMainCoordinator(withScene scene: UIWindowScene) -> MainCoordinator {
        let window = UIWindow(windowScene: scene)
        let navigationController = NavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
        
        return MainCoordinator(navigationController: navigationController)
    }
}

