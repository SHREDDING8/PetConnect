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
    
    func usernameExist()
    func emailExist()
    func unknownError()
    
    func goToEmailConfirmation()
}

protocol SignUpPresenterProtocol:AnyObject{
    var model:SignUpModel? { get set }
    init(view:SignUpViewProtocol, model:SignUpModel, networkService:UsersNetworkServiceProtocol)
    
    func textFieldChanged()
    func passwordDidChange(value:String)
    
    /// Set login to model
    /// - Parameter value: login value
    func setLogin(value:String)
    
    /// Set email to model
    /// - Parameter value: email value
    func setEmail(value:String)
    
    /// Set password to model
    /// - Parameter value: password value
    func setPassword(value:String)
    
    /// Set confirm password to model
    /// - Parameter value: confirm password value
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
        model?.username = value
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
    
    func signUpTapped(){
        Task {
            do{
                // check existing username
                
                let isUsernameExist = try await networkService?.existUsername(username: model?.username ?? "")
                
                let isSignUp = try await networkService?.signUp(username: model?.username ?? "", email: model?.email ?? "", password: model?.password ?? "")
                
                
                if isUsernameExist ?? false{
                    DispatchQueue.main.async {
                        self.view?.usernameExist()
                    }
                    return
                }
                                
                if !(isSignUp ?? false){
                    DispatchQueue.main.async {
                        self.view?.unknownError()
                        return
                    }
                }else{
                    DispatchQueue.main.sync {
                        self.view?.goToEmailConfirmation()
                    }
                }
                
                
            }catch UsersError.emailExist {
                
                DispatchQueue.main.async {
                    self.view?.emailExist()
                }
                
            } catch{
                DispatchQueue.main.async {
                    self.view?.unknownError()
                }
                return
            }
            
        }
    }
    
}
