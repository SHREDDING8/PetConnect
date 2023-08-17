//
//  AuthResponseJson.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import Foundation

struct SignInResponseJsonStruct:Decodable{
    let accessToken:String
    let refreshToken:String
}

struct SignInErrorJsonStruct:Decodable{
    let status:String
    let message:String
    let details:String
    let code:Int
}
