//
//  requestJson.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import Foundation

struct SignInRequestJsonStruct:Codable{
    let emailOrUsername:String
    let password:String
}
