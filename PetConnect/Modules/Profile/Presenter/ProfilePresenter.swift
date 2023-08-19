//
//  ProfilePresenter.swift
//  PetConnect
//
//  Created by Алёна Максимова on 19.08.2023.
//

import Foundation

protocol ProfileViewProtocol:AnyObject{
    
}

protocol ProfilePresenterProtocol: AnyObject {
    init(view: ProfileViewProtocol)
}

class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfileViewProtocol?
    
    required init(view: ProfileViewProtocol) {
        self.view = view
    }
    
}
