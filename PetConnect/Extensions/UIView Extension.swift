//
//  UIView Extension.swift
//  PetConnect
//
//  Created by SHREDDING on 18.08.2023.
//

import Foundation
import UIKit

extension UIView{
    
    
    /// set Opacity to view
    /// - Parameters:
    ///   - opacity: opacity value
    ///   - animated: is animate 
    func setOpacity(opacity:Float, animated:Bool){
        if animated{
            UIView.animate(withDuration: 0.3) {
                self.layer.opacity = opacity
            }
        }else{
            self.layer.opacity = opacity
        }

    }
    
}


