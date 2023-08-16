//
//  HomePageView.swift
//  PetConnect
//
//  Created by Andrey on 12.08.2023.
//

import UIKit

protocol HomePageViewDelegate: AnyObject {
    func buyTracker()
    func addNotification()
}

class HomePageView: UIView {
    weak var delegate: HomePageViewDelegate?
    
    lazy var petsCollectionViewHeight = petsCollectionView.heightAnchor.constraint(equalToConstant: 0)
    lazy var petsCollectionViewTopAnchor = petsCollectionView.topAnchor.constraint(equalTo: buyTrackerButton.bottomAnchor, constant: 0)
    
    private lazy var buyTrackerButton: UIButton = {
        let element = UIButton()
        element.setImage(UIImage(named: "banner"), for: .normal)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(buyTrackerButtonClicked), for: .touchUpInside)
        return element
    }()
    
    private lazy var petsCollectionView: PetsCollectionView = {
        let element = PetsCollectionView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var notificationsHeaderHStack: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var notificationHeader: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var notificationLabel: UILabel = {
        let element = UILabel()
        element.text = "Напоминания"
        element.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        element.textColor = UIColor(named: "on-surface")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var addNotificationButton: UIButton = {
        let element = UIButton()
        element.setTitle("＋  Добавить", for: .normal)
        element.setTitleColor(UIColor(named: "primary"), for: .normal)
        element.setTitleColor(UIColor(named: "primary-30%"), for: .highlighted)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(addNotificationButtonClicked), for: .touchUpInside)
        return element
    }()
    
    lazy var notificationsTableView: UITableView = {
        let element = UITableView()
        element.register(NotificationsTableViewCell.self, forCellReuseIdentifier: "Cell")
        element.separatorStyle = .none
        element.backgroundColor = UIColor(named: "NavBarBgColor")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        addSubview(buyTrackerButton)
        addSubview(petsCollectionView)
        addSubview(notificationHeader)
        notificationHeader.addSubview(notificationLabel)
        notificationHeader.addSubview(addNotificationButton)
        addSubview(notificationsTableView)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            
            buyTrackerButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 72), //navBar (64) + space (8)
            buyTrackerButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buyTrackerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14), //White line 6px at right side of banner
            
            petsCollectionViewTopAnchor,
            petsCollectionViewHeight,
            petsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            petsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            
            notificationHeader.topAnchor.constraint(equalTo: petsCollectionView.bottomAnchor, constant: 20),
            notificationHeader.heightAnchor.constraint(equalToConstant: 44),
            notificationHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            notificationHeader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            notificationLabel.centerYAnchor.constraint(equalTo: notificationHeader.centerYAnchor),
            notificationLabel.leadingAnchor.constraint(equalTo: notificationHeader.leadingAnchor),
            
            addNotificationButton.centerYAnchor.constraint(equalTo: notificationHeader.centerYAnchor),
            addNotificationButton.trailingAnchor.constraint(equalTo: notificationHeader.trailingAnchor),
            addNotificationButton.heightAnchor.constraint(equalTo: notificationHeader.heightAnchor),
            addNotificationButton.widthAnchor.constraint(equalToConstant: 125),
            
            notificationsTableView.topAnchor.constraint(equalTo: notificationHeader.bottomAnchor, constant: 12),
            notificationsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -3),
            notificationsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 18),
            notificationsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
}

@objc extension HomePageView {
    func buyTrackerButtonClicked() {
        delegate?.buyTracker()
    }
    
    func addNotificationButtonClicked() {
        delegate?.addNotification()
    }
}

extension HomePageView {
    func updatePets(petsArray: [Pet]) {
        petsCollectionView.pets = petsArray
        petsCollectionView.reloadData()
    }
}
