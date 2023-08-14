//
//  AuthNetworkService.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import Foundation
import Alamofire

protocol AuthNetworkServiceProtocol{
    func signIn(login:String,password:String, completion: @escaping (String?,String?)->Void )
}
class AuthNetworkService:AuthNetworkServiceProtocol{
    let generalUrlString = GeneralNetworkService.domain + "auth/"
    
    
    func signIn(login:String,password:String, completion: @escaping (String?,String?)->Void ){
        let urlString = generalUrlString + "sign-in"
        let url = URL(string: urlString)!
        
        let body = SignInRequestJsonStruct(emailOrUsername: login, password: password)
        let headers = HTTPHeaders(
            [
                "Content-Type" : "application/json"
            ]
        )
        
        AF.request(url, method: .post, parameters: body, encoder: .json, headers: headers).response { response in
            switch response.result {
            case .success(let success):
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
