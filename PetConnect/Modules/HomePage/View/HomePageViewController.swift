//
//  HomePageViewController.swift
//  PetConnect
//
//  Created by Andrey on 12.08.2023.
//

import UIKit

final class HomePageViewController: UIViewController {
    
    var homePageView = HomePageView()
    var presenter: HomePagePresenterProtocol!
    
    //MARK: - Life cycles
    override func loadView() {
        super.loadView()
        
        view = homePageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homePageView.delegate = self
        homePageView.notificationsTableView.dataSource = self
        homePageView.notificationsTableView.delegate = self
        presenter.requestPets()
        
        configurePrimaryNavBar(with: "Главная", image: UIImage(named: "kris"))
    }
}

extension HomePageViewController: HomePageViewControllerProtocol {
    func updatePets(with pets: [Pet]) {
        if !pets.isEmpty {
            homePageView.updatePets(petsArray: pets)
            
            //Show collection view with pets
            homePageView.petsCollectionViewTopAnchor.constant = 20
            homePageView.petsCollectionViewHeight.constant = 124
            homePageView.layoutIfNeeded()
        } else {
            //Hide collection view with pets
            homePageView.petsCollectionViewTopAnchor.constant = 0
            homePageView.petsCollectionViewHeight.constant = 0
            homePageView.layoutIfNeeded()
        }
    }
}

extension HomePageViewController: HomePageViewDelegate {
    func addNotification() {
        print("Transition to add notification page")
    }
    
    func buyTracker() {
        print("Transition to buy tracker page")
    }
}

extension HomePageViewController: PrimaryNavBarViewDelegate {
    func openUserProfile() {
        print("Transition to user profile page")
    }
}

extension HomePageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? NotificationsTableViewCell else {
            fatalError("Error")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
