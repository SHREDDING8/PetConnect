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
    /// Create Main Builder
    /// - Returns: Main Tab Bar
    static func createMainBuilder() -> UIViewController
    
    static func setAuthWindow(window:UIWindow?)
    static func setMainWindow(window:UIWindow?)
    
    static func createAuth()->UIViewController
  
    /// Create home page
    /// - Returns: home page
    static func createHomePage()->UIViewController
    
    /// Create pet page
    /// - Returns: pet page
    static func createPetPage()->UIViewController
    
    /// Create walk page
    /// - Returns: walk page
    static func createWalkPage()->UIViewController
    
    /// Create profile page
    /// - Returns: profile page
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
        return BaseNavigationController(rootViewController: HomePageAssembly.configuredModule())
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
