//
//  SignUpModel.swift
//  PetConnect
//
//  Created by SHREDDING on 15.08.2023.
//

import Foundation

struct SignUpModel{
    var username:String = ""
    var email:String = ""
    var password:String = ""
    var confirmPassword:String = ""
    
    
    /// check username or email or password or confirmPassword is empty
    /// - Returns: true - if atleast one value is empty
    func isEmptyData()->Bool{
        return username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty
    }
}
