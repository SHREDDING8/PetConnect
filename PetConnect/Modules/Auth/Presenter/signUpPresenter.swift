//
//  signUpPresenter.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import Foundation

protocol SignUpViewProtocol:AnyObject{
    
}

protocol SignUpPresenterProtocol:AnyObject{
    init(view:SignUpViewProtocol)
}
class SignUpPresenter:SignUpPresenterProtocol{
    weak var view:SignUpViewProtocol?
    
    required init(view:SignUpViewProtocol) {
        self.view = view
    }
}
