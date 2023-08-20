//
//  HomePageBuilder.swift
//  PetConnect
//
//  Created by Алёна Максимова on 19.08.2023.
//

import UIKit
protocol HomePageBuilderProtocol{
    
    /// creates Notification Page
    /// - Returns: notification UIViewController
    static func createNotificationPage()->UIViewController
}

class HomePageBuilder: HomePageBuilderProtocol{
    
    static func createNotificationPage() -> UIViewController {
        let view = NotificationViewController()
        
        let presenter = NotificationPresenter(view: view)
        view.presenter = presenter
        return view
    }
}

