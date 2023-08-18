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
    func getAccessTokenTimeSaved()->Date?
    func getRefreshTokenTimeSaved()->Date?
    
    func deleteAccessToken()
    func deleteRefreshToken()
    
}

open class KeyChainStorage:KeyChainStorageProtocol{
    
    private let keychain = KeychainSwift()
    
    private let accessTokenKey: String = "accessToken"
    private let accessTokenTimeSavedKey: String = "accessTokenTime"
    
    private let refreshTokenKey: String = "refreshToken"
    private let refreshokenTimeSavedKey: String = "refreshTokenTime"
    
    let dateFormatter = DateFormatter()
    let dateFormat = "MM-dd-yyyy HH:mm"
    
    init(){
        dateFormatter.dateFormat = dateFormat
    }
    
    func saveAccessToken(token: String) {
        keychain.set(token, forKey: self.accessTokenKey)
        keychain.set(dateFormatter.string(from: Date.now), forKey: self.accessTokenTimeSavedKey)
    }
    
    func saveRefreshToken(token: String) {
        keychain.set(token, forKey: self.refreshTokenKey)
        keychain.set(dateFormatter.string(from: Date.now), forKey: self.refreshokenTimeSavedKey)
    }
    
    func getAccessToken() -> String? {
        let accessToken = keychain.get(self.accessTokenKey)
        return accessToken
    }
    
    func getRefreshToken() -> String? {
        let refreshToken = keychain.get(self.refreshTokenKey)
        return refreshToken
    }
    
    func getAccessTokenTimeSaved()->Date?{
        let dateString = keychain.get(self.accessTokenTimeSavedKey)
        let date = dateFormatter.date(from: dateString ?? "")
        return date
    }
    
    func getRefreshTokenTimeSaved()->Date?{
        let dateString = keychain.get(self.refreshokenTimeSavedKey)
        let date = dateFormatter.date(from: dateString ?? "")
        return date
    }
    
    func deleteAccessToken(){
        keychain.delete(self.accessTokenKey)
    }
    func deleteRefreshToken(){
        keychain.delete(self.refreshTokenKey)
    }
    
}
