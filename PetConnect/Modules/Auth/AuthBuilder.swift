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
    static func createEmailConfirmationPage(email:String, password:String)->UIViewController
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
        let view = SignUpViewController()
        let model = SignUpModel()
        let networkService = UsersNetworkService()
        let presenter = SignUpPresenter(view: view, model: model, networkService:networkService)
        view.presenter = presenter
        return view
    }
    
    static func createEmailConfirmationPage(email:String, password:String)->UIViewController{
        let view = EmailConfirmationViewController()
        let networkService = UsersNetworkService()
        let authNetworkService = AuthNetworkService()
        let presenter = EmailConfirmationPresenter(view: view,networkService: networkService, authNetworkService: authNetworkService, email: email, password: password)
        
        view.presenter = presenter
        return view
    }
    
}
