//
//  signUpPresenter.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import Foundation

protocol SignUpViewProtocol:AnyObject{
    func enableRegisrationButton()
    func disableRegisrationButton()
    func setWeakPassword()
    func setStrongPassword()
}

protocol SignUpPresenterProtocol:AnyObject{
    init(view:SignUpViewProtocol, model:SignUpModel, networkService:UsersNetworkServiceProtocol)
    
    func textFieldChanged()
    func passwordDidChange(value:String)
    
    func setLogin(value:String)
    func setEmail(value:String)
    func setPassword(value:String)
    func setConfirmPassword(value:String)
    
    func signUpTapped()
}
class SignUpPresenter:SignUpPresenterProtocol{
    weak var view:SignUpViewProtocol?
    var model:SignUpModel?
    var networkService:UsersNetworkServiceProtocol?
    
    required init(view:SignUpViewProtocol, model:SignUpModel, networkService:UsersNetworkServiceProtocol) {
        self.view = view
        self.model = model
        self.networkService = networkService
    }
    
    func textFieldChanged(){
        if !(model?.isEmptyData() ?? true) && AuthValidation.validatePassword(value: (model?.password ?? "")) && AuthValidation.validateEmail(value: model?.email ?? "") && model?.password == model?.confirmPassword{
            view?.enableRegisrationButton()
        }else{
            view?.disableRegisrationButton()
        }
    }
    
    func passwordDidChange(value:String){
        if !AuthValidation.validatePassword(value: (value)) {
            view?.setWeakPassword()
        }else{
            view?.setStrongPassword()
        }
    }
    
    func setLogin(value:String){
        model?.login = value
    }
    
    func setEmail(value:String){
        model?.email = value
    }
    
    func setPassword(value:String){
        model?.password = value
    }
    
    /// Adding confirm password to model
    /// - Parameter value: confirm password value
    func setConfirmPassword(value:String){
        model?.confirmPassword = value
    }
    
    func signUpTapped(){
        
    }
    
}
