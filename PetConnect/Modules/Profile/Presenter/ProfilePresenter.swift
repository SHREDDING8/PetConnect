//
//  ProfilePresenter.swift
//  PetConnect
//
//  Created by Алёна Максимова on 19.08.2023.
//

import Foundation

protocol ProfileViewProtocol:AnyObject{
    func logOutSuccessfull()
    func logOutError()
}

protocol ProfilePresenterProtocol: AnyObject {
    init(view: ProfileViewProtocol, networkService:AuthNetworkService, keyChainService:KeyChainStorageProtocol)
    func logOutTapped()
    func deleteTapped()
}

class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfileViewProtocol?

    var networkService:AuthNetworkService?
    var keyChainService:KeyChainStorageProtocol?
    
    required init(view: ProfileViewProtocol, networkService:AuthNetworkService, keyChainService:KeyChainStorageProtocol) {
        self.view = view
        self.networkService = networkService
        self.keyChainService = keyChainService
    }
    
    func logOutTapped(){
        Task{
            if let logOutResult = try await networkService?.logOut(){
                if logOutResult{
                    DispatchQueue.main.async {
                        self.view?.logOutSuccessfull()
                        self.keyChainService?.deleteAccessToken()
                        self.keyChainService?.deleteRefreshToken()
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.view?.logOutError()
                    }
                   
                }
            }
            
            DispatchQueue.main.async {
                self.view?.logOutError()
            }
            
            
        }
        
    }
    
    func deleteTapped() {
        print("Delete")
    }
    
}
