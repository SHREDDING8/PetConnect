//
//  UIViewController + ext.swift
//  PetConnect
//
//  Created by Andrey on 13.08.2023.
//

import UIKit

extension UIViewController {
    func configurePrimaryNavBar(with text: String, image: UIImage?) {
        navigationController?.navigationBar.isHidden = true
        
        let navBar = PrimaryNavBarView()
        navBar.configure(with: text, image: image)
        
        navBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navBar)
        
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 64),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
