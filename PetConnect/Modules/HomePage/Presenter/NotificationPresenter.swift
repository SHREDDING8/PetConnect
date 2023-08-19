//
//  NotificationPresenter.swift
//  PetConnect
//
//  Created by Алёна Максимова on 19.08.2023.
//

import Foundation

protocol NotificationViewProtocol: AnyObject {

    func enableLogInButton()
    
}

protocol NotificationPresenterProtocol: AnyObject {
    init(
        view: NotificationViewProtocol
    )
    
    func signInTapped()
}

class NotificationPresenter: NotificationPresenterProtocol {

    weak var view: NotificationViewProtocol?
    
    
    
    required init(
        view: NotificationViewProtocol) {
        self.view = view
    }
    
    func signInTapped(){
    }
    
}
