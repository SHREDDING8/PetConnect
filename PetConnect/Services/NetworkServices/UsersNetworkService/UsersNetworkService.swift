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
    func existEmail(email:String) async throws -> Bool
    func signUp(username:String, email:String, password:String) async throws -> Bool
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
    
    func existEmail(email:String) async throws -> Bool{
        
        let url = URL(string: GeneralNetworkService.UsersControllerUrls.existEmail + "?email=\(email)")!
        
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
    
    
    // MARK: - signUp
    func signUp(username:String, email:String, password:String) async throws -> Bool{
        
        //            // check username existing
        //            let usernameIsExist = try await self.existUsername(username: username)
        //
        //            if usernameIsExist{
        //                completion(.usernameExist, )
        //                return
        //            }
        //
        //            // check email existing
        //
        //            let emailIsExist = try await self.existEmail(email: email)
        //
        //            if emailIsExist{
        //                completion(.emailExist, nil, nil)
        //                return
        //            }
        
        // signUp
        
        let signUpUrl = URL(string: GeneralNetworkService.UsersControllerUrls.signUp)!
        
        let body = SignUpRequestStruct(username: username, email: email, password: password)
        
        let result:Bool = await withCheckedContinuation { continuation in
            
            AF.request(signUpUrl, method: .post, parameters: body, encoder: .json).response { response in
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
