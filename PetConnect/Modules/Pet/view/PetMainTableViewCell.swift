//
//  PetCollectionView.swift
//  PetConnect
//
//  Created by Leonid Romanov on 19.08.2023.
//

import UIKit

class PetCollectionViewCell: UICollectionViewCell {
  
  static let cellID = "PetCellID"
  
  let imagePet: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 30
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  let imageGender: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  let namePet: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "SF Pro", size: 16)
    label.textColor = UIColor(named: "textColor")
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let porodaLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "SF Pro", size: 14)
    label.textColor = .lightGray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let ageLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "SF Pro", size: 14)
    label.textColor = .lightGray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let stackView = UIStackView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.layer.cornerRadius = 30
    self.backgroundColor = .systemGray6
    self.addSubview(imagePet)
    self.addSubview(stackView)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.addSubview(imageGender)
    stackView.addSubview(namePet)
    stackView.addSubview(porodaLabel)
    stackView.addSubview(ageLabel)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    NSLayoutConstraint.activate([
      imagePet.topAnchor.constraint(equalTo: self.topAnchor),
      imagePet.leftAnchor.constraint(equalTo: self.leftAnchor),
      imagePet.heightAnchor.constraint(equalToConstant: 115),
      imagePet.widthAnchor.constraint(equalToConstant: 115),
      
      stackView.centerYAnchor.constraint(equalTo: imagePet.centerYAnchor),
      stackView.leftAnchor.constraint(equalTo: imagePet.rightAnchor, constant: 16),
      stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
      stackView.heightAnchor.constraint(equalToConstant: 101),
      
      namePet.leftAnchor.constraint(equalTo: imageGender.rightAnchor, constant: 2),
      namePet.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 16),
      namePet.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -18),
      
      imageGender.centerYAnchor.constraint(equalTo: namePet.centerYAnchor),
      imageGender.heightAnchor.constraint(equalToConstant: 16),
      imageGender.widthAnchor.constraint(equalToConstant: 16),
      imageGender.leftAnchor.constraint(equalTo: stackView.leftAnchor),
      
      porodaLabel.topAnchor.constraint(equalTo: namePet.bottomAnchor, constant: 6),
      porodaLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor),
      porodaLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor),
      
      ageLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
      ageLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor),
      ageLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
