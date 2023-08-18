//
//  HomePagePresenter.swift
//  PetConnect
//
//  Created by Andrey on 12.08.2023.
//

import UIKit

class HomePagePresenter: HomePagePresenterProtocol {
    
    weak var view: HomePageViewControllerProtocol!
    
    func requestPets() {
        view.updatePets(with: obtainPetsArray())
    }
}

//MARK: - Functions for debug
private extension HomePagePresenter {
    func obtainPetsArray() -> [Pet] {
        return [Pet(name: "Чубака", photo: UIImage(named: "chubaka")),
                Pet(name: "Кристофер", photo: UIImage(named: "kris")),
                Pet(name: "Бэлла", photo: UIImage(named: "bella")),
                Pet(name: "Чубака", photo: UIImage(named: "chubaka"))]
//        return []
    }
}
