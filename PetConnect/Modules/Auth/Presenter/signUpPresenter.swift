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
}

protocol SignUpPresenterProtocol:AnyObject{
    init(view:SignUpViewProtocol, model:SignUpModel)
    
    func textFieldChanged()
    
    func setLogin(value:String)
    func setEmail(value:String)
    func setPassword(value:String)
    func setConfirmPassword(value:String)
}
class SignUpPresenter:SignUpPresenterProtocol{
    weak var view:SignUpViewProtocol?
    var model:SignUpModel?
    
    required init(view:SignUpViewProtocol, model:SignUpModel) {
        self.view = view
        self.model = model
    }
    
    func textFieldChanged(){
        if (model?.isEmptyData() ?? true){
            view?.disableRegisrationButton()
        }else{
            view?.enableRegisrationButton()
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
    
    func setConfirmPassword(value:String){
        model?.confirmPassword = value
    }
    
}
