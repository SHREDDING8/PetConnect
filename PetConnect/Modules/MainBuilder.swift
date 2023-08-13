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
    
    static func createHomePage()->UIViewController
    static func createPetPage()->UIViewController
    static func createWalkPage()->UIViewController
    static func createProfilePage()->UIViewController
}

// MARK: - MainBuilder
class MainBuilder:MainBuilderProtocol{
    static func createMainBuilder() -> UIViewController{
        let tabBar = MainTabBarViewController()
        return tabBar
    }
    
    // MARK: - Main Pages
    static func createHomePage()->UIViewController{
        return BaseNavigationController(rootViewController: HomePageViewController())
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
