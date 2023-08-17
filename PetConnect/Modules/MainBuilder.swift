//
//  MainBuilder.swift
//  PetConnect
//
//  Created by SHREDDING on 12.08.2023.
//

import Foundation
import UIKit

// MARK: - MainBuilderProtocol
protocol MainBuilderProtocol{
    static func createMainBuilder() -> UIViewController
    
    static func setAuthWindow(window:UIWindow?)
    static func setMainWindow(window:UIWindow?)
    
    static func createAuth()->UIViewController
    
    static func createHomePage()->UIViewController
    static func createPetPage()->UIViewController
    static func createWalkPage()->UIViewController
    static func createProfilePage()->UIViewController
}

// MARK: - MainBuilder
class MainBuilder:MainBuilderProtocol{
    
    static func setAuthWindow(window:UIWindow?){
        let options = UIWindow.TransitionOptions()
        
        options.direction = .fade
        options.duration = 0.3
        
        window?.set(rootViewController: MainBuilder.createAuth(), options: options)
    }
    static func setMainWindow(window:UIWindow?){
        let options = UIWindow.TransitionOptions()
        
        options.direction = .fade
        options.duration = 0.3
        
        window?.set(rootViewController: MainBuilder.createMainBuilder(), options: options)
    }
    
    static func createMainBuilder() -> UIViewController{
        let tabBar = MainTabBarViewController()
        return tabBar
    }
    
    // MARK: - Auth
    static func createAuth()->UIViewController{
        let view = GreetingViewController()
        let presenter = GreetingPresenter(view: view)
        view.presenter = presenter
        return BaseNavigationController(rootViewController: view)
    }
    
    // MARK: - Main Pages
    static func createHomePage()->UIViewController{
        return BaseNavigationController()
    }
    
    static func createPetPage()->UIViewController{
        return UINavigationController()
    }
    
    static func createWalkPage()->UIViewController{
        return UINavigationController()
    }
    
    static func createProfilePage()->UIViewController{
        return UINavigationController()
    }
    
}
