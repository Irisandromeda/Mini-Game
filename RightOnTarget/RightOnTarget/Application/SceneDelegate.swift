//
//  SceneDelegate.swift
//  RightOnTarget
//
//  Created by Irisandromeda on 12.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        
        window?.backgroundColor = .red
    }

}

