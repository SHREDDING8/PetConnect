//
//  ProfileViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 19.08.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Variables
    var presenter: ProfilePresenterProtocol?
    
    private lazy var sectionLablel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Профиль"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "avatar.png")
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = image.frame.height/2
        
        return image
    }()
    
    // MARK: - Account Information
    
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "profile.png")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private lazy var profileLablel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Логин"
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var emailImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "email.png")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private lazy var emailLablel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "User@gmail.com"
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var notificationImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "notification.png")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private lazy var notificationLablel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Уведомления"
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var notificationSwitch: UISwitch = {
        let notification = UISwitch()
        notification.translatesAutoresizingMaskIntoConstraints = false
        notification.isOn = true
        
        return notification
    }()
    
    private lazy var deleteImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "delete.png")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private lazy var deleteLablel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Удалить аккаунт"
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = UIColor(named: "primary")
        
        return label
    }()
    
    private lazy var logoutImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logout.png")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private lazy var logoutLablel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Выход"
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = UIColor(named: "primary")
        
        return label
    }()
    
    // MARK: - Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.largeTitleDisplayMode = .never
        
        setUpView()
    }
    
    func setUpView() {
        view.addSubview(sectionLablel)
        view.addSubview(avatarImageView)
        view.addSubview(profileImageView)
        view.addSubview(profileLablel)
        view.addSubview(emailImageView)
        view.addSubview(emailLablel)
        view.addSubview(notificationImageView)
        view.addSubview(notificationLablel)
        view.addSubview(notificationSwitch)
        view.addSubview(deleteImageView)
        view.addSubview(deleteLablel)
        view.addSubview(logoutImageView)
        view.addSubview(logoutLablel)
        
        NSLayoutConstraint.activate(staticConstraints())
        
        print(profileImageView.frame.origin.y)
        drawLine(fromX: 20, fromY: 400, toX: Int(view.frame.width)-20, toY: 400)
        drawLine(fromX: 20, fromY: 460, toX: Int(view.frame.width)-20, toY: 460)
        drawLine(fromX: 20, fromY: 512, toX: Int(view.frame.width)-20, toY: 512)
        drawLine(fromX: 20, fromY: 570, toX: Int(view.frame.width)-20, toY: 570)
        
        
        
    }
    
    func drawLine(fromX: Int, fromY: Int, toX: Int, toY: Int) {
         let path = UIBezierPath()
         path.move(to: CGPoint(x: fromX, y: fromY))
         path.addLine(to: CGPoint(x: toX, y: toY))

         let shapeLayer = CAShapeLayer()
         shapeLayer.path = path.cgPath
         shapeLayer.strokeColor = UIColor(named: "outline")?.cgColor
         shapeLayer.lineWidth = 1.0

         view.layer.addSublayer(shapeLayer)
    }
    
    func staticConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            sectionLablel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            sectionLablel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            avatarImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            avatarImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: sectionLablel.bottomAnchor, constant: 38),
            profileImageView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 55),
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileLablel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            profileLablel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            emailImageView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 32),
            emailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailLablel.centerYAnchor.constraint(equalTo: emailImageView.centerYAnchor),
            emailLablel.leadingAnchor.constraint(equalTo: emailImageView.trailingAnchor, constant: 16),
            notificationImageView.topAnchor.constraint(equalTo: emailImageView.bottomAnchor, constant: 32),
            notificationImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            notificationLablel.centerYAnchor.constraint(equalTo: notificationImageView.centerYAnchor),
            notificationLablel.leadingAnchor.constraint(equalTo: notificationImageView.trailingAnchor, constant: 16),
            notificationSwitch.centerYAnchor.constraint(equalTo: notificationImageView.centerYAnchor),
            notificationSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            deleteImageView.topAnchor.constraint(equalTo: notificationImageView.bottomAnchor, constant: 32),
            deleteImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            deleteLablel.centerYAnchor.constraint(equalTo: deleteImageView.centerYAnchor),
            deleteLablel.leadingAnchor.constraint(equalTo: deleteImageView.trailingAnchor, constant: 16),
            logoutImageView.topAnchor.constraint(equalTo: deleteImageView.bottomAnchor, constant: 32),
            logoutImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoutLablel.centerYAnchor.constraint(equalTo: logoutImageView.centerYAnchor),
            logoutLablel.leadingAnchor.constraint(equalTo: logoutImageView.trailingAnchor, constant: 16),
            ])
        
        return constraints
    }
    
}

extension ProfileViewController: ProfileViewProtocol{
    
}

