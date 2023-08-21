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
    
    let category = CustomTextField(cornerRadius: 28, upperText: "Категория*", textFieldPlaceholder: "Корм или лекарство*", supportingText: "")
    let name = CustomTextField(cornerRadius: 28, upperText: "Название*", textFieldPlaceholder: "Название*", supportingText: "")
    let date = CustomTextField(cornerRadius: 28, upperText: "Дата окончания*", textFieldPlaceholder: "Дата окончания*", supportingText: "")
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = ready ? UIColor(named: "primary") : UIColor(named: "on-surface")?.withAlphaComponent(0.12)
        button.titleLabel?.textColor = ready ? .white : UIColor(named: "on-surface")?.withAlphaComponent(0.38)
        button.layer.cornerRadius = 21
        button.addTarget(self, action: #selector(saveNotifications), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+ Добавить прием", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor(named: "primary"), for: .normal)
        button.addTarget(self, action: #selector(addNotification), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
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
        view.addSubview(category)
        view.addSubview(name)
        view.addSubview(date)
        view.addSubview(addButton)
        category.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(staticConstraints())
    }
    
    func staticConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            saveButton.heightAnchor.constraint(equalToConstant: 44),
            category.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            category.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            category.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            category.heightAnchor.constraint(equalToConstant: 80),
            name.topAnchor.constraint(equalTo: category.bottomAnchor, constant: -10),
            name.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            name.heightAnchor.constraint(equalToConstant: 80),
            date.topAnchor.constraint(equalTo: name.bottomAnchor, constant: -10),
            date.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            date.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            date.heightAnchor.constraint(equalToConstant: 80),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 0),
            ])
        
        return constraints
    }
    
    @objc func addNotification() {
        print("Added")
    }
    
    @objc func saveNotifications() {
        presenter?.savedTapped()
        navigationController?.popViewController(animated: true)
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

