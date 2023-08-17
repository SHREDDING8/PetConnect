//
//  AuthNetworkService.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import Foundation
import Alamofire

public enum AuthErrors{
    case usernameExist
    case emailExist
    case unknown
}

protocol AuthNetworkServiceProtocol{
    func signIn(login:String,password:String, completion: @escaping (String?,String?)->Void)
    
}
class AuthNetworkService:AuthNetworkServiceProtocol{
    
    // MARK: - signIn
    
    /// Request to server Sign In to account
    /// - Parameters:
    ///   - login: username or email value
    ///   - password: password value
    ///   - completion: returns accessToken, refreshToken
    func signIn(login:String,password:String, completion: @escaping (String?,String?)->Void ){
        let urlString = GeneralNetworkService.AuthControllerUrls.signIn
        let url = URL(string: urlString)!
        
        let body = SignInRequestJsonStruct(emailOrUsername: login, password: password)
        
        AF.request(url, method: .post, parameters: body, encoder: .json).response { response in
            switch response.result {
            case .success(let success):
                print("success")
                if let responseDecoded = try? JSONDecoder().decode(SignInResponseJsonStruct.self, from: success ?? Data()){
                    completion(responseDecoded.accessToken, responseDecoded.refreshToken)
                }else{
                    completion(nil,nil)
                }
                
            case .failure(_):
                completion(nil,nil)
            }
        }
    }
    

    
}
