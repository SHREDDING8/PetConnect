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
    func showSignInError()
    func goToConfirmEmail(email:String,password:String)
    func goToMainPage()
}

protocol SignInPresenterProtocol:AnyObject{
    init(view:SignInViewProtocol, model:signInModel, networkService:AuthNetworkServiceProtocol)
    
    func setSignInData(type:signInFields, value:String)
    func signInTapped()
}


class SignInPresenter:SignInPresenterProtocol{

    weak var view:SignInViewProtocol?
    var model:signInModel?
    var networkService:AuthNetworkServiceProtocol?
    
    
    required init(view:SignInViewProtocol, model:signInModel,networkService:AuthNetworkServiceProtocol) {
        self.view = view
        self.model = model
        self.networkService = networkService
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
    
    func signInTapped(){
        Task{
            do{
                let resultSignIn = try await self.networkService?.signIn(login: model?.getLogin() ?? "", password: model?.getPassword() ?? "")
                
                DispatchQueue.main.async {
                    self.view?.goToMainPage()
                }
                
            }catch AuthErrors.notActivated{
                DispatchQueue.main.async {
                    self.view?.goToConfirmEmail(
                        email: self.model?.getLogin() ?? "",
                        password: self.model?.getPassword() ?? ""
                    )
                }
                
            }catch {
                DispatchQueue.main.async {
                    self.view?.showSignInError()
                }
            }
        }
    }
    
}