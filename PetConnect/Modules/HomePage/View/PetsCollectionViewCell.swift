//
//  PetsCollectionViewCell.swift
//  PetConnect
//
//  Created by Andrey on 13.08.2023.
//

import Foundation
import UIKit

class PetsCollectionViewCell: UICollectionViewCell {
    
    static let nameFont = UIFont.systemFont(ofSize: 12, weight: .medium)
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "on-surface")
        label.textAlignment = .center
        label.font = nameFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let photoImageView: UIImageView = {
        let element = UIImageView()
        element.layer.masksToBounds = true
        element.layer.cornerRadius = 30
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setupViews() {
        backgroundColor = .none
        
        addSubview(nameLabel)
        addSubview(photoImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
//            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -8)
        ])
    }
}
