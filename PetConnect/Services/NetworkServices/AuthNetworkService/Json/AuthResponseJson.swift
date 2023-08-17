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
