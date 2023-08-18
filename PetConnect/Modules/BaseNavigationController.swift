//
//  CustomNavigationViewController.swift
//  PetConnect
//
//  Created by Andrey on 12.08.2023.
//

import UIKit

// MARK: - BaseNavigationController
class BaseNavigationController: UINavigationController {
    
    /// configure view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    /// Add style to navigationBar and view
    private func configure() {
        view.backgroundColor = UIColor(named: "NavBarBgColor")
        
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "on-surface") ?? UIColor(),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        
        self.navigationBar.prefersLargeTitles = true
        
    }
}
