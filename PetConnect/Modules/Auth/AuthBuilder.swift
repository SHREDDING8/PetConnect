//
//  AuthBuilder.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import Foundation
import UIKit
protocol AuthBuilderProtocol{
    static func createSignInPage()->UIViewController
    static func createSignUpPage()->UIViewController
}

class AuthBuilder:AuthBuilderProtocol{
    
    static func createSignInPage() -> UIViewController {
        let view = SignInViewController()
        let model = signInModel()
        let networkService = AuthNetworkService()
        let presenter = SignInPresenter(view: view, model: model, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    static func createSignUpPage() -> UIViewController {
        return UIViewController()
    }
    
    
}
