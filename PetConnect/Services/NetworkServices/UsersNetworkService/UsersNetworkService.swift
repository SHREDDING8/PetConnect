//
//  UsersNetworkService.swift
//  PetConnect
//
//  Created by SHREDDING on 17.08.2023.
//

import Foundation
import Alamofire

protocol UsersNetworkServiceProtocol{
    func existUsername(username:String) async throws -> Bool
    func existEmail(username:String) async throws -> Bool
    func signUp(username:String, email:String, password:String, completion: @escaping (AuthErrors?,String?,String?)->Void)
}

class UsersNetworkService:UsersNetworkServiceProtocol{
    
    func existUsername(username:String) async throws -> Bool{
        
        let url = URL(string: GeneralNetworkService.UsersControllerUrls.usernameExist + "?username=\(username)")!
                
        
        let result:Bool = try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).response { response in
                switch response.result {
                case .success(let success):
                    continuation.resume(returning: success == Data("true".utf8) )
                case .failure(_):
                    continuation.resume(throwing: NSError(domain: "Unknown", code: 500) )
                }
            }
        }
        
        return result
    }
    
    func existEmail(username:String) async throws -> Bool{
        return true
    }
    
    
    // MARK: - signUp
    func signUp(username:String, email:String, password:String, completion: @escaping (AuthErrors?,String?,String?)->Void){
        
        // MARK: - check username existing
        
//        let existUsernameUrlString
        
    }
}
