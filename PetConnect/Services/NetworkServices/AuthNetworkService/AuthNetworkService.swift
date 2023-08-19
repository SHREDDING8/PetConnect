//
//  AuthNetworkService.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import Foundation
import Alamofire


/// Possible Auth network service errors
public enum AuthErrors:Error{
    case usernameExist
    case emailExist
    case notActivated
    case wrongEmailOrPassword
    case unknown
}

protocol AuthNetworkServiceProtocol{
    
    ///  Request to server to SignIn
    /// - Parameters:
    ///   - login: username or email value
    ///   - password: password value
    /// - Returns: (accessToken, refreshToken)
    func signIn(login:String,password:String) async throws -> (String, String)
    
    static func refreshToken() async throws -> Bool
    
}
class AuthNetworkService:AuthNetworkServiceProtocol{
    
    // MARK: - signIn
    
    func signIn(login:String,password:String) async throws -> (String, String){
        let urlString = GeneralNetworkService.AuthControllerUrls.signIn
        let url = URL(string: urlString)!
        
        let body = SignInRequestJsonStruct(emailOrUsername: login, password: password)
        
        let result: (String, String) = try await withCheckedThrowingContinuation { continuation in
            
            AF.request(url, method: .post, parameters: body, encoder: .json).response { response in
                switch response.result {
                case .success(let success):
                    if let responseDecoded = try? JSONDecoder().decode(SignInResponseJsonStruct.self, from: success ?? Data()){
                        continuation.resume(returning: (responseDecoded.accessToken, responseDecoded.refreshToken))
                    }else{
                        if let errorDecoded = try? JSONDecoder().decode(SignInErrorJsonStruct.self, from: success ?? Data()){
                            
                            if errorDecoded.code == 1003{
                                continuation.resume(throwing: AuthErrors.notActivated)
                                return
                            }else if  errorDecoded.code == 1001{
                                continuation.resume(throwing: AuthErrors.wrongEmailOrPassword)
                                return
                                
                            }
                            
                        }
                        continuation.resume(throwing: AuthErrors.unknown)
                    }
                    
                case .failure(_):
                    continuation.resume(throwing: AuthErrors.unknown)
                }
            }
        }
        
        return result
    }
    
    
    static func refreshToken() async throws -> Bool{
        
        let keyChainService = KeyChainStorage()
        
        if !keyChainService.isAccessTokenAvailable(){
            return true
        }
        
        let url = URL(string: GeneralNetworkService.AuthControllerUrls.refreshToken)!
        
        let body = RefreshTokenRequestJsonStruct(refreshToken: keyChainService.getRefreshToken() ?? "")
        
        let result:Bool =  try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .post, parameters: body, encoder: .json).response { response in
                switch response.result {
                case .success(let success):
                    if let tokensDecoded = try? JSONDecoder().decode(RefreshTokenResponseJsonStruct.self, from: success!){
                        
                        keyChainService.saveAccessToken(token: tokensDecoded.accessToken)
                        keyChainService.saveRefreshToken(token: tokensDecoded.refreshToken)
                    }else{
                        continuation.resume(throwing: AuthErrors.unknown)
                    }
                    
                case .failure(_):
                    continuation.resume(throwing: AuthErrors.unknown)
                }
            }
        }
        
        return result
    }
    
}
