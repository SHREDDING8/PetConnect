//
//  MainTabBarViewController.swift
//  PetConnect
//
//  Created by SHREDDING on 12.08.2023.
//

import UIKit

// MARK: - Main Tab Bar Configurator
class MainTabBarViewController: UITabBarController {
    
    private enum PageConstants{
        
        case home
        case pet
        case walk
        case profile
        
        /// Get a title for item in the Main Tab Bar
        /// - Returns: name of the page
        func getTitle()->String{
            switch self {
            
            case .home:
                return "Главная"
            case .pet:
                return "Питомцы"
            case .walk:
                return "Прогулки"
            case .profile:
                return "Профиль"
            }
            
        }
        
        /// Select inactive image for unelected items in the Main Tab Bar
        /// - Returns: imge for Tab Bar
        func getImage()->UIImage?{
            switch self {
            
            case .home:
                return UIImage(named: "HomeIsNotActive")
            case .pet:
                return UIImage(named: "PetIsNotActive")
            case .walk:
                return UIImage(named: "WalkIsNotActive")
            case .profile:
                return UIImage(systemName: "person")
            }
        }
        
        /// Select active image for pressed item in the Main Tab Bar
        /// - Returns: imge for Tab Bar
        func getSelectedImage()->UIImage?{
            switch self {
            case .home:
                return UIImage(named: "HomeIsActive")
            case .pet:
                return UIImage(named: "PetIsActive")
            case .walk:
                return UIImage(named: "WalkIsActive")
            case .profile:
                return UIImage(named: "personIsActive")
            }
        }
    }

    /// Configure viewControllers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homePage =  self.configureViewController(MainBuilder.createHomePage(), .home)
        let petPage = self.configureViewController(MainBuilder.createPetPage(), .pet)
        let walkPage = self.configureViewController(MainBuilder.createWalkPage(), .walk)
        let profilePage = self.configureViewController(MainBuilder.createProfilePage(), .profile)
        
        self.viewControllers = [homePage,petPage,walkPage,profilePage]
    }
    
    /// Set up Tab Bar item
    /// - Parameters:
    ///   - viewController: viewController for the particular page
    ///   - page: type of the page
    /// - Returns: set up viewController
    private func configureViewController(_ viewController:UIViewController, _ page:PageConstants)->UIViewController{
        viewController.tabBarItem.title = page.getTitle()
        viewController.tabBarItem.image =  page.getImage()
        viewController.tabBarItem.selectedImage = page.getSelectedImage()
        self.tabBar.tintColor = UIColor(named: "TabBarSelectedColor")
        self.tabBar.backgroundColor = UIColor(named: "TabBarBgColor")
        return viewController
    }
}
