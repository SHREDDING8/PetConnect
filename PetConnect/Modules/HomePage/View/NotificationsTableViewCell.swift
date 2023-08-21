//
//  NotificationsTableViewCell.swift
//  PetConnect
//
//  Created by Andrey on 14.08.2023.
//

import UIKit

protocol NotificationsTableViewCellDelegate: AnyObject {
    func buttonPressed()
}

class NotificationsTableViewCell: UITableViewCell {
    
    weak var delegate: NotificationsTableViewCellDelegate?
    
    private lazy var bgView: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(named: "foodNotifCell")
        element.layer.cornerRadius = 20
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var notifTitle: UILabel = {
        let element = UILabel()
        element.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        element.textColor = UIColor(named: "on-surface")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var notifType: UILabel = {
        let element = UILabel()
        element.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        element.textColor = UIColor(named: "on-surface")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var notifImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    // add prescriptions
    private lazy var fisrtNotif: UILabel = {
        let element = UILabel()
        element.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        element.textColor = UIColor(named: "on-surface")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(name nameLable: String, category categoryLabel: Category, prescriptions prescriptionLabel: [String]) {
        bgView.backgroundColor = categoryLabel.getBackgroundColor()
        notifTitle.text = nameLable
        notifType.text = categoryLabel.getTitle()
        notifImage.image = categoryLabel.getImage()
        // add prescriptions
    }
    
    private func setupViews() {
        addSubview(bgView)
        bgView.addSubview(notifTitle)
        bgView.addSubview(notifType)
        bgView.addSubview(notifImage)
        // add prescriptions
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.centerYAnchor.constraint(equalTo: centerYAnchor),
            bgView.heightAnchor.constraint(equalToConstant: 116),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            notifTitle.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 18),
            notifTitle.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 20),
            notifType.topAnchor.constraint(equalTo: notifTitle.bottomAnchor, constant: 3),
            notifType.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 20),
            notifImage.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -20),
            notifImage.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            // add prescriptions
        ])
    }
}
