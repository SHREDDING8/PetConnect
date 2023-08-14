//
//  CustomNavigationViewController.swift
//  PetConnect
//
//  Created by Andrey on 12.08.2023.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        view.backgroundColor = UIColor(named: "NavBarBgColor")
        
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "on-surface") ?? UIColor(),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        
        self.navigationBar.prefersLargeTitles = true
        
    }
}
