//
//  GeneralNetworkService.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import Foundation

protocol GeneralNetworkServiceProtocol{
    static var domain:String { get }
}

class GeneralNetworkService{
    static let domain:String = "https://pet-connect.ru/api/"
}
