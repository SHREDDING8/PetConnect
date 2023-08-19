//
//  MenuHeaderView.swift
//  PetConnect
//
//  Created by Leonid Romanov on 19.08.2023.
//

import UIKit

class MenuHeaderView: UIView {
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "SF Pro", size: 22)
    label.textColor = UIColor(named: "textColor")
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let porodaLabel: UILabel = {
    let label = UILabel()
    label.textColor = .lightGray
    label.font = UIFont(name: "SF Pro", size: 16)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(nameLabel)
    self.addSubview(porodaLabel)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
      nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
      nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
      
      porodaLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
      porodaLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
      porodaLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
      porodaLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
