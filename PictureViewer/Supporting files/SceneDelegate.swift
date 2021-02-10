//
//  SceneDelegate.swift
//  PictureViewer
//
//  Created by Лера Тарасенко on 09.02.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        window?.makeKeyAndVisible()
        
        let layuot = UICollectionViewFlowLayout()
        
        let vc = CollectionViewController(collectionViewLayout: layuot)
        let navigation = UINavigationController(rootViewController: vc)
        
        window?.rootViewController = navigation
        
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

