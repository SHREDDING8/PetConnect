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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false

        return contentView
    }()
     
    private lazy var sectionLabel: UILabel = {
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
    
    
    private lazy var deleteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        label.textColor = UIColor(named: "primary")
        
        return label
    }()
    
    private lazy var logoutView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        label.textColor = UIColor(named: "primary")
        
        return label
    }()
    
    // MARK: - Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.largeTitleDisplayMode = .never
        
        let delete = UITapGestureRecognizer(target: self, action: #selector(deleteTapped))
        self.deleteView.isUserInteractionEnabled = true
        self.deleteView.addGestureRecognizer(delete)
        
        let logout = UITapGestureRecognizer(target: self, action: #selector(logOutTapped))
        self.logoutView.isUserInteractionEnabled = true
        self.logoutView.addGestureRecognizer(logout)
        
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        drawLine(fromX: 20, fromY: Int(profileImageView.frame.maxY)+16, toX: Int(view.frame.width)-20, toY: Int(profileImageView.frame.maxY)+16)
        drawLine(fromX: 20, fromY: Int(emailImageView.frame.maxY)+16, toX: Int(view.frame.width)-20, toY: Int(emailImageView.frame.maxY)+16)
        drawLine(fromX: 20, fromY: Int(notificationImageView.frame.maxY)+16, toX: Int(view.frame.width)-20, toY: Int(notificationImageView.frame.maxY)+16)
        drawLine(fromX: 20, fromY: Int(deleteView.frame.maxY)+16, toX: Int(view.frame.width)-20, toY: Int(deleteView.frame.maxY)+16)
        
    }
    
    func setUpView() {
        view.addSubview(sectionLabel)
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(avatarImageView)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(profileLablel)
        contentView.addSubview(emailImageView)
        contentView.addSubview(emailLablel)
        contentView.addSubview(notificationImageView)
        contentView.addSubview(notificationLablel)
        contentView.addSubview(notificationSwitch)
        contentView.addSubview(deleteView)
        deleteView.addSubview(deleteImageView)
        deleteView.addSubview(deleteLablel)
        contentView.addSubview(logoutView)
        logoutView.addSubview(logoutImageView)
        logoutView.addSubview(logoutLablel)
        
        NSLayoutConstraint.activate(staticConstraints())
    }
    
    func drawLine(fromX: Int, fromY: Int, toX: Int, toY: Int) {
         let path = UIBezierPath()
         path.move(to: CGPoint(x: fromX, y: fromY))
         path.addLine(to: CGPoint(x: toX, y: toY))

         let shapeLayer = CAShapeLayer()
         shapeLayer.path = path.cgPath
         shapeLayer.strokeColor = UIColor(named: "outline")?.cgColor
         shapeLayer.lineWidth = 1.0

         contentView.layer.addSublayer(shapeLayer)
    }
    
    func staticConstraints() -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: [
            
            sectionLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
            sectionLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            
            scrollView.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1),
            
            avatarImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            avatarImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 38),
            
            profileImageView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 55),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            profileLablel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            profileLablel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            
            
            emailImageView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 32),
            emailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            emailLablel.centerYAnchor.constraint(equalTo: emailImageView.centerYAnchor),
            emailLablel.leadingAnchor.constraint(equalTo: emailImageView.trailingAnchor, constant: 16),
            
            
            notificationImageView.topAnchor.constraint(equalTo: emailImageView.bottomAnchor, constant: 32),
            notificationImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            notificationLablel.centerYAnchor.constraint(equalTo: notificationImageView.centerYAnchor),
            notificationLablel.leadingAnchor.constraint(equalTo: notificationImageView.trailingAnchor, constant: 16),
            
            
            notificationSwitch.centerYAnchor.constraint(equalTo: notificationImageView.centerYAnchor),
            notificationSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -28),
            
            deleteView.topAnchor.constraint(equalTo: notificationImageView.bottomAnchor, constant: 32),
            deleteView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
            deleteView.heightAnchor.constraint(equalTo: deleteImageView.heightAnchor, multiplier: 1),
            deleteImageView.leadingAnchor.constraint(equalTo: deleteView.leadingAnchor, constant: 20),
            deleteImageView.centerYAnchor.constraint(equalTo: deleteView.centerYAnchor),
            deleteLablel.centerYAnchor.constraint(equalTo: deleteImageView.centerYAnchor),
            deleteLablel.leadingAnchor.constraint(equalTo: deleteImageView.trailingAnchor, constant: 16),
            
            logoutView.topAnchor.constraint(equalTo: deleteView.bottomAnchor, constant: 32),
            logoutView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
            logoutView.heightAnchor.constraint(equalTo: deleteImageView.heightAnchor, multiplier: 1),
            logoutImageView.centerYAnchor.constraint(equalTo: logoutView.centerYAnchor),
            logoutImageView.leadingAnchor.constraint(equalTo: logoutView.leadingAnchor, constant: 20),
            logoutLablel.centerYAnchor.constraint(equalTo: logoutImageView.centerYAnchor),
            logoutLablel.leadingAnchor.constraint(equalTo: logoutImageView.trailingAnchor, constant: 16),
            logoutView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            ])
        
        return constraints
    }
    
    @objc func logOutTapped(){
        let alertLogout = UIAlertController(title: "Подтвердите действие", message: "Вы уверены, что действительно хотите выйти из учетной записи PetConnect?", preferredStyle: .alert)
         
        alertLogout.addAction(UIAlertAction(title: "Отмена", style: .default, handler: nil))
        alertLogout.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: { _ in
            self.presenter?.logOutTapped()
        }))
    
        self.present(alertLogout, animated: true)
    }
    
    @objc func deleteTapped(){
        let alertLogout = UIAlertController(title: "Подтвердите действие", message: "Вы уверены, что действительно хотите удалить аккаунт?", preferredStyle: .alert)
         
        alertLogout.addAction(UIAlertAction(title: "Отмена", style: .default, handler: nil))
        alertLogout.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
             self.presenter?.deleteTapped()
        }))
    
        self.present(alertLogout, animated: true)
    }
}

extension ProfileViewController: ProfileViewProtocol{
    func logOutSuccessfull() {
        MainBuilder.setAuthWindow(window: self.view.window)
    }
    
    func logOutError() {
        let alert = UIAlertController(title: "Ошибка", message: "Повторите попытку", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
    
}

