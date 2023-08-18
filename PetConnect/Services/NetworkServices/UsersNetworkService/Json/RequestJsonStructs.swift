//
//  RequestJsonStructs.swift
//  PetConnect
//
//  Created by SHREDDING on 17.08.2023.
//

import Foundation


/// struct for configure JSON in SignUp
struct SignUpRequestStruct:Codable{
    let username:String
    let email:String
    let password:String
}
/// struct for configure JSON in activation account
struct ActivationRequestStruct:Codable{
    let email:String
    let code:String
}
