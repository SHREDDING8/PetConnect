//
//  EmailConfirmationPresenter.swift
//  PetConnect
//
//  Created by SHREDDING on 17.08.2023.
//

import Foundation

protocol EmailConfirmationViewProtocol:AnyObject{
    func confirmationError()
    func confrimationOk()
    
    func resendOk()
    func resendError()
    
}

protocol EmailConfirmationPresenterProtocol:AnyObject{
    var passCode:[Int] { get set }
    init(view:EmailConfirmationViewProtocol, networkService:UsersNetworkServiceProtocol, email:String, password:String)
    
    func confirmTapped()
    func resendTapped()
    
    func login()
}
class EmailConfirmationPresenter:EmailConfirmationPresenterProtocol{
    weak var view:EmailConfirmationViewProtocol?
    let networkService:UsersNetworkServiceProtocol?
    let email:String!
    let password:String!
    var passCode:[Int] = []
    
    required init(view:EmailConfirmationViewProtocol, networkService:UsersNetworkServiceProtocol, email:String, password:String) {
        self.view = view
        self.networkService = networkService
        self.email = email
        self.password = password
    }
    
    func confirmTapped(){
        let code = String(passCode[0]) + String(passCode[1]) + String(passCode[2]) + String(passCode[3])
        Task{
            
            let result = try await networkService?.activation(email:email, code: code)
            
            if (result ?? false){
                DispatchQueue.main.async {
                    self.view?.confrimationOk()
                }
                
            }else{
                DispatchQueue.main.async {
                    self.view?.confirmationError()
                }
            }
            
        }
    }
    
    func resendTapped(){
        Task{
            let result = try await networkService?.activtionResend(email: email)
            
            if (result ?? false){
                DispatchQueue.main.async {
                    self.view?.resendOk()
                }
            }else{
                DispatchQueue.main.async {
                    self.view?.resendError()
                }
            }
            
        }
    }
    
    func login() {
        
    }
}
