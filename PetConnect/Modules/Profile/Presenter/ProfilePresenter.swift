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
    init(view: ProfileViewProtocol, networkService:AuthNetworkService)
    func logOutTapped()
}

class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfileViewProtocol?
    var networkService:AuthNetworkService?
    
    required init(view: ProfileViewProtocol, networkService:AuthNetworkService) {
        self.view = view
        self.networkService = networkService
    }
    
    func logOutTapped(){
        Task{
            if let logOutResult = try await networkService?.logOut(){
                if logOutResult{
                    DispatchQueue.main.async {
                        self.view?.logOutSuccessfull()
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
    
}
