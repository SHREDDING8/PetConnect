//
//  NotificationViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 19.08.2023.
//

import UIKit

class NotificationViewController: UIViewController {
    
    // MARK: - Variables
    
    var presenter: NotificationPresenterProtocol?
    var ready: Bool = false
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = ready ? UIColor(named: "primary") : UIColor(named: "on-surface")?.withAlphaComponent(0.12)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        setUpView()
    }
    
    fileprivate func configureNavBar(){
        
        self.navigationItem.title = "Назад"
        self.navigationItem.largeTitleDisplayMode = .always
        
    }
        
    // MARK: - Actions
    func setUpView() {
        view.addSubview(saveButton)
        NSLayoutConstraint.activate(staticConstraints())
    }
    
    func staticConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 61)
            ])
        
        return constraints
    }
    
}

extension NotificationViewController: NotificationViewProtocol{
    func enableLogInButton() {
        print("enable")
    }
    
    
    
}

