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
    
    public func configure(img image: UIImage, category categoryLabel: String, news newsLabel: String) {
        
    }
    
    private func setupViews() {
        addSubview(bgView)
        bgView.addSubview(notifTitle)
        bgView.addSubview(notifType)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.centerYAnchor.constraint(equalTo: centerYAnchor),
            bgView.heightAnchor.constraint(equalToConstant: 116),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
