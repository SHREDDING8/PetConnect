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
    /// enable SignIn button
    func enableLogInButton()
    /// disable SignIn button
    func disableLogInButton()
    /// showing SignIn errpr
    func showSignInError()
    /// transition to confirm email page
    func goToConfirmEmail(email:String,password:String)
    /// transition to Main tab bar
    func goToMainPage()
}

protocol SignInPresenterProtocol:AnyObject{
    init(
        view:SignInViewProtocol,
        model:signInModel,
        networkService:AuthNetworkServiceProtocol,
        keyChainService:KeyChainStorageProtocol?
    )
    
    
    /// setting credentionals to model
    /// - Parameters:
    ///   - type: login or password
    ///   - value: value
    func setSignInData(type:signInFields, value:String)
    /// handle tap on signIn button
    func signInTapped()
}


class SignInPresenter:SignInPresenterProtocol{

    weak var view:SignInViewProtocol?
    var model:signInModel?
    var networkService:AuthNetworkServiceProtocol?
    var keyChainService:KeyChainStorageProtocol?
    
    
    required init(
        view:SignInViewProtocol,
        model:signInModel,
        networkService:AuthNetworkServiceProtocol,
        keyChainService:KeyChainStorageProtocol?) {
        self.view = view
        self.model = model
        self.networkService = networkService
        self.keyChainService = keyChainService
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
                
                if resultSignIn != nil{
                    keyChainService?.saveAccessToken(token: resultSignIn!.0)
                    keyChainService?.saveRefreshToken(token: resultSignIn!.1)
                    DispatchQueue.main.async {
                        self.view?.goToMainPage()
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.view?.showSignInError()
                    }
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
