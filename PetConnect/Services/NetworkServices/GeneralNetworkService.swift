//
//  GeneralNetworkService.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import Foundation
import Alamofire

protocol GeneralNetworkServiceProtocol{
    static var domain:String { get }
}

class GeneralNetworkService{
    /// General domain for requests to server
    static let domain:String = "https://pet-connect.ru/api/"
    
    /// Possible request controllers urls
    public enum ControllersUrls{
        static let auth =  GeneralNetworkService.domain + "auth/"
        static let users = GeneralNetworkService.domain + "users/"
    }
    
    /// Possible urls for auth controller
    public enum AuthControllerUrls{
        static let signIn = GeneralNetworkService.ControllersUrls.auth + "sign-in"
        static let refreshToken = GeneralNetworkService.ControllersUrls.auth + "refresh-token"
        static let logout = GeneralNetworkService.ControllersUrls.auth + "logout"
    }
    
    /// Possible url for users controller
    public enum UsersControllerUrls{
        static let updateUser = ControllersUrls.users + "/"
        static let deleteUser = ControllersUrls.users + "/"
        static let signUp = ControllersUrls.users + "sign-up"
        static let getMyInfo = ControllersUrls.users + "me"
        static let usernameExist = ControllersUrls.users + "exist-username"
        static let existEmail = ControllersUrls.users + "exist-email"
        
        static let activation = ControllersUrls.users + "activation"
        static let activationResend = ControllersUrls.users + "activation/resend"
    }
        
    public class Headers{
        private var headers:[String:String] = [:]
        
        private enum Keys{
            static let deviceId = "deviceId"
            static let accessToken = "Authorization"
            
        }
        
        public func getHeaders()->HTTPHeaders{
            return HTTPHeaders(headers)
        }
        
        public func addAccessTokenHeader(){
            
            let keyChainService = KeyChainStorage()
            
            headers[Keys.accessToken] = "Bearer \(keyChainService.getAccessToken() ?? "")"
        }
        
    }
}
