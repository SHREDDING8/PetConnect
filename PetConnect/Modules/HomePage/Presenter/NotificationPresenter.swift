//
//  NotificationPresenter.swift
//  PetConnect
//
//  Created by Алёна Максимова on 19.08.2023.
//

import Foundation

protocol NotificationViewProtocol: AnyObject {

    func enableSaveButton()
    func disableSaveButton()
    
}

protocol NotificationPresenterProtocol: AnyObject {
    init(
        view: NotificationViewProtocol
    )
    
    func savedTapped()
}

class NotificationPresenter: NotificationPresenterProtocol {

    weak var view: NotificationViewProtocol?
    
    
    
    required init(
        view: NotificationViewProtocol) {
        self.view = view
    }
    
    func savedTapped() {
        var newNotification = Notification(name: "Name")
        NotificationPlaceholder.notifications.append(newNotification)
        print("Saved")
    }
    
}
