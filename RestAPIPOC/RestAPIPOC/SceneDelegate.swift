//
//  SceneDelegate.swift
//  RestAPIPOC
//
//  Created by Siddharth Kumar on 06/10/20.
//  Copyright © 2020 MyOrganisation. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        let viewController = HomeViewController()
        viewController.view.backgroundColor = .white
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        window?.makeKeyAndVisible()
    }

}

