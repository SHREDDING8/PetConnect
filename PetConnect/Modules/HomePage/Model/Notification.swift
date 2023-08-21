//
//  Notification.swift
//  PetConnect
//
//  Created by Алёна Максимова on 20.08.2023.
//

import Foundation
import UIKit

enum Category {
    case food
    case medicine
    
    func getTitle() -> String {
        switch self {
            
        case .food:
            return "Корм"
        case .medicine:
            return "Лекарство"
        }
    }
    
    func getImage() -> UIImage? {
        switch self {
        
        case .food:
            return UIImage(named: "dogBowl")
        case .medicine:
            return UIImage(named: "dogMedicine")
        }
    }
    
    func getBackgroundColor() -> UIColor? {
        switch self {
        
        case .food:
            return UIColor(named: "foodNotifCell")
        case .medicine:
            return UIColor(named: "medicineNotifCell")
        }
    }
}

struct Notification {
    var name: String
    var category: Category
    var prescriptions: [String]
}

class NotificationPlaceholder {
    static var notifications: [Notification] = []
}
