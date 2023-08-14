//
//  SignInPresenter.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import Foundation

public enum signInFields{
    case login
    case password
}

protocol SignInViewProtocol:AnyObject{
    func enableLogInButton()
    func disableLogInButton()
}

protocol SignInPresenterProtocol:AnyObject{
    init(view:SignInViewProtocol, model:signInModel)
    
    func setSignInData(type:signInFields, value:String)
}
class SignInPresenter:SignInPresenterProtocol{

    weak var view:SignInViewProtocol?
    var model:signInModel?
    
    
    required init(view:SignInViewProtocol, model:signInModel) {
        self.view = view
        self.model = model
    }
    
    func setSignInData(type: signInFields, value: String) {
        switch type {
        case .login:
            model?.setLogin(login: value)
        case .password:
            model?.setPassword(password: value)
        }
        if (model?.isEmptyData() ?? true){
            view?.disableLogInButton()
        }else{
            view?.enableLogInButton()
        }
    }
    
}
