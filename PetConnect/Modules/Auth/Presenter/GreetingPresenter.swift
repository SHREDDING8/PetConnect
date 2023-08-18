//
//  GreetingPresenter.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import Foundation

protocol GreetingViewProtocol:AnyObject{
    
}

protocol GreetingPresenterProtocol:AnyObject{
    init(view:GreetingViewProtocol)
}

class GreetingPresenter:GreetingPresenterProtocol{
    weak var view:GreetingViewProtocol?
    
    required init(view:GreetingViewProtocol) {
        self.view = view
    }
    
}
