//
//  KeyChainStorage.swift
//  PetConnect
//
//  Created by SHREDDING on 18.08.2023.
//

import Foundation
import KeychainSwift


/// Service to handle keyChain storage (key - value)
protocol KeyChainStorageProtocol{
    
    func saveAccessToken(token:String)
    func saveRefreshToken(token:String)
    
    func getAccessToken()->String?
    func getRefreshToken()->String?
    
    func deleteAccessToken()
    func deleteRefreshToken()
    
}

open class KeyChainStorage:KeyChainStorageProtocol{
    
    private let keychain = KeychainSwift()
    
    private let accessTokenKey: String = "accessToken"
    
    private let refreshTokenKey: String = "refreshToken"
    
    func saveAccessToken(token: String) {
        keychain.set(token, forKey: self.accessTokenKey)
    }
    
    func saveRefreshToken(token: String) {
        keychain.set(token, forKey: self.refreshTokenKey)
    }
    
    func getAccessToken() -> String? {
        let accessToken = keychain.get(self.accessTokenKey)
        return accessToken
    }
    
    func getRefreshToken() -> String? {
        let refreshToken = keychain.get(self.refreshTokenKey)
        return refreshToken
    }
    
    func deleteAccessToken(){
        keychain.delete(self.accessTokenKey)
    }
    func deleteRefreshToken(){
        keychain.delete(self.refreshTokenKey)
    }
    
}
