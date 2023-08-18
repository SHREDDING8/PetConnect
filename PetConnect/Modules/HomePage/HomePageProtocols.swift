//
//  HomePageProtocols.swift
//  PetConnect
//
//  Created by Andrey on 12.08.2023.
//

import Foundation

protocol HomePageViewControllerProtocol: AnyObject {
    func updatePets(with pets: [Pet])
}

protocol HomePagePresenterProtocol: AnyObject {
    func requestPets()
}
