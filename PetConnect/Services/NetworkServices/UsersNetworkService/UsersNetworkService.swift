//
//  UsersNetworkService.swift
//  PetConnect
//
//  Created by SHREDDING on 17.08.2023.
//

import Foundation
import Alamofire

protocol UsersNetworkServiceProtocol{
    
    /// The request to server to check existing username
    /// - Parameter username: username value
    /// - Returns: true - if username exist
    func existUsername(username:String) async throws -> Bool
    
    /// The request to server to check existing email
    /// - Parameter email: email value
    /// - Returns: true - if email exist
    func existEmail(email:String) async throws -> Bool
    
    /// The request to server to signUp
    /// - Parameters:
    ///   - username: username value
    ///   - email: email value
    ///   - password: password value
    /// - Returns: true - is signUp is successuful
    func signUp(username:String, email:String, password:String) async throws -> Bool
    
    /// The request to server to check code to activae account
    /// - Parameters:
    ///   - email: email value
    ///   - code: passCode value
    /// - Returns: true - if activation is ok
    func activation(email:String, code:String) async throws -> Bool
    
    /// The request to server to resend activation code
    /// - Parameter email: email value
    /// - Returns: true - if resend is ok
    func activtionResend(email:String) async throws -> Bool
}

/// Possible errors in Users Network Service
enum UsersError:Error{
    case emailExist
    case unknown
}

/// Users Network Service
class UsersNetworkService:UsersNetworkServiceProtocol{
    
    func existUsername(username:String) async throws -> Bool{
        
        let url = URL(string: GeneralNetworkService.UsersControllerUrls.usernameExist + "?username=\(username)")!
        
        let result:Bool = try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).response { response in
                switch response.result {
                case .success(let success):
                    continuation.resume(returning: success! == Data("true".utf8) )
                case .failure(_):
                    continuation.resume(throwing: NSError(domain: "Unknown", code: 500) )
                }
            }
        }
        
        return result
    }
    
    func existEmail(email:String) async throws -> Bool{
        
        let url = URL(string: GeneralNetworkService.UsersControllerUrls.existEmail + "?email=\(email)")!
        
        let result:Bool = try await withCheckedThrowingContinuation { continuation in
            
            AF.request(url, method: .get).response { response in
                switch response.result {
                case .success(let success):
                    continuation.resume(returning: String(data: success ?? Data(), encoding: .utf8).flatMap(Bool.init) ?? true )
                case .failure(_):
                    continuation.resume(throwing: NSError(domain: "Unknown", code: 500) )
                }
            }
        }
        
        return result
    }
    
    
    // MARK: - signUp
    func signUp(username:String, email:String, password:String) async throws -> Bool{
        
        let signUpUrl = URL(string: GeneralNetworkService.UsersControllerUrls.signUp)!
        
        let body = SignUpRequestStruct(username: username, email: email, password: password)
                
        let result:Bool = try await withCheckedThrowingContinuation { continuation in
            
            AF.request(signUpUrl, method: .post, parameters: body, encoder: .json).response { response in
                
                switch response.result {
                    
                case .success(let success):
                    if let error = try? JSONDecoder().decode(SignInErrorJsonStruct.self, from: success ?? Data()){
                        
                        switch error.message{
                            
                        case "Email already exists!":
                            continuation.resume(throwing: UsersError.emailExist)
                            
                        default:
                            continuation.resume(throwing: UsersError.unknown)
                        }
                        
                        return
                    }
                    
                    continuation.resume(returning: true)
                case .failure(_):
                    continuation.resume(throwing: UsersError.unknown)
                }
            }
        }
        
        return result
    }
    
    func activation(email:String, code:String) async throws -> Bool{
        
        let url = URL(string: GeneralNetworkService.UsersControllerUrls.activation)!
        
        let body = ActivationRequestStruct(email: email, code: code)
        
        let result:Bool = await withCheckedContinuation { continuation in
            
            AF.request(url, method: .post, parameters: body, encoder: .json).response { response in
                switch response.result {
                case .success(let success):
                    continuation.resume(returning: String(data: success ?? Data(), encoding: .utf8).flatMap(Bool.init) ?? false )
                case .failure(_):
                    continuation.resume(returning: false)
                }
            }
        }
        
        return result
    }
    func activtionResend(email:String) async throws -> Bool{
        
        let url = URL(string: GeneralNetworkService.UsersControllerUrls.activationResend + "?email=\(email)")!
        
        let result:Bool = await withCheckedContinuation { continuation in
            AF.request(url, method: .get).response { response in
                switch response.result {
                case .success(_):
                    continuation.resume(returning: true)
                case .failure(_):
                    continuation.resume(returning: false)
                }
            }
        }
        
        return result
    }
}
