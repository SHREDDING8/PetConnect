//
//  AuthResponseJson.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import Foundation

/// JSON struct to decode SignIn response
struct SignInResponseJsonStruct:Decodable{
    let accessToken:String
    let refreshToken:String
}

/// JSON struct to decode SignIn errors
struct SignInErrorJsonStruct:Decodable{
    let status:String
    let message:String
    let details:String
    let code:Int
}

struct RefreshTokenResponseJsonStruct:Codable{
    let accessToken:String
    let refreshToken:String
}
