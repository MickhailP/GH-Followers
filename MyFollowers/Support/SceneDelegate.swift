//
//  SceneDelegate.swift
//  MyFollowers
//
//  Created by Миша Перевозчиков on 14.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
	

	
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = GFTabBarController()
        window?.makeKeyAndVisible()
        
		configureNavigationBarAppearance()
    }


    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}

// MARK: - Configuration methods
extension SceneDelegate {
    
    func configureNavigationBarAppearance() {
		let navBar = UINavigationBar()
		
		UINavigationBar.appearance().tintColor = .systemGreen
		
		let standardAppearance = UINavigationBarAppearance()
		standardAppearance.configureWithOpaqueBackground()
		
		let compactAppearance = standardAppearance.copy()
		
		navBar.standardAppearance = standardAppearance
		navBar.scrollEdgeAppearance = standardAppearance
		navBar.compactAppearance = compactAppearance
		if #available(iOS 15.0, *) { // For compatibility with earlier iOS.
			navBar.compactScrollEdgeAppearance = compactAppearance
		}
    }
}

