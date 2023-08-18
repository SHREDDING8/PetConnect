//
//  logInModel.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import Foundation

struct signInModel{
    private var login:String = ""
    private var password:String = ""
    
    
    mutating func setLogin(login:String){
        self.login = login
    }
    mutating func setPassword(password:String){
        self.password = password
    }
    
    func getLogin()->String{
        return login
    }
    func getPassword()->String{
        return password
    }
    
    /// checks login or password is empty
    /// - Returns: true - if data is empty
    func isEmptyData()->Bool{
        if login.isEmpty || password.isEmpty{
            return true
        }
        return false
    }
}
