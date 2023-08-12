//
//  MainTabBarViewController.swift
//  PetConnect
//
//  Created by SHREDDING on 12.08.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    private enum PageConstants{
        
        case home
        case pet
        case walk
        case profile
        
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homePage =  self.configureViewController(MainBuilder.createHomePage(), .home)
        let petPage = self.configureViewController(MainBuilder.createPetPage(), .pet)
        let walkPage = self.configureViewController(MainBuilder.createWalkPage(), .walk)
        let profilePage = self.configureViewController(MainBuilder.createProfilePage(), .profile)
        
        self.viewControllers = [homePage,petPage,walkPage,profilePage]
        
        
    }
    
    private func configureViewController(_ viewController:UIViewController, _ page:PageConstants)->UIViewController{
        viewController.tabBarItem.title = page.getTitle()
        viewController.tabBarItem.image =  page.getImage()
        viewController.tabBarItem.selectedImage = page.getSelectedImage()
        self.tabBar.tintColor = UIColor(named: "TabBarSelectedColor")
        return viewController
    }
}
