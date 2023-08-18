//
//  requestJson.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import Foundation

/// Struct to configure JSON for SignIn Request
struct SignInRequestJsonStruct:Codable{
    let emailOrUsername:String
    let password:String
}

struct RefreshTokenRequestJsonStruct:Codable{
    let refreshToken:String
}
