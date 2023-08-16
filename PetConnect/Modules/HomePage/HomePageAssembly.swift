//
//  HomePageAssembley.swift
//  PetConnect
//
//  Created by Andrey on 12.08.2023.
//

import UIKit

class HomePageAssembly {
    
    class func configuredModule() -> UIViewController {
        let view = HomePageViewController()
        let presenter = HomePagePresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
