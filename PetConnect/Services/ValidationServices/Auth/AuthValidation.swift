//
//  AuthValidation.swift
//  PetConnect
//
//  Created by SHREDDING on 15.08.2023.
//

import Foundation

class AuthValidation{
    static func validateEmail(value:String)->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: value)
    }
    
    static func validatePassword(value:String)->Bool{

        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[A-Za-z0-9]{8,100}"
//        let passwordRegexEnglishCaps =
        
        print(value)
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        
        return passwordPred.evaluate(with: value)
        
        
    }
}
