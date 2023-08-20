//
//  MenuTableViewCell.swift
//  PetConnect
//
//  Created by Leonid Romanov on 19.08.2023.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
  
  let cellID = "menuCell"
  
  let descLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "SF Pro", size: 14)
    label.textColor = .systemGray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let detailLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "SF Pro", size: 16)
    label.textColor = UIColor(named: "textColor")
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.addSubview(descLabel)
    self.addSubview(detailLabel)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    NSLayoutConstraint.activate([
      descLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
      descLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
      
      detailLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
      descLabel.centerYAnchor.constraint(equalTo: descLabel.centerYAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
