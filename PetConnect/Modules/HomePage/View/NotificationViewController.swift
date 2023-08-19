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
    var ready: Bool = true
    
    let name = CustomTextField(cornerRadius: 28, upperText: "Название*", textFieldPlaceholder: "Название*", supportingText: "")
    let date = CustomTextField(cornerRadius: 28, upperText: "Дата окончания*", textFieldPlaceholder: "Дата окончания*", supportingText: "")
    
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
        view.addSubview(name)
        //view.addSubview(date)
        NSLayoutConstraint.activate(staticConstraints())
    }
    
    func staticConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 61),
            name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            name.heightAnchor.constraint(equalToConstant: 80),
//            date.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 16),
//            date.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            date.heightAnchor.constraint(equalToConstant: 80),
            ])
        
        return constraints
    }
    
}

extension NotificationViewController: NotificationViewProtocol{
    func enableSaveButton() {
        print("enable")
    }
    
    func disableSaveButton() {
        print("disable")
    }
}

