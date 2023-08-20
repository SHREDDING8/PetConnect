//
//  PetTableViewCell.swift
//  PetConnect
//
//  Created by Leonid Romanov on 17.08.2023.
//

import UIKit

class PetTableViewCell: UITableViewCell {
  
  let mainTextField: UITextField = {
    let textField = UITextField()
    textField.font = UIFont(name: "SF Pro", size: 16)
    textField.textColor = UIColor(named: "textColor")
    textField.layer.cornerRadius = 20
    textField.layer.borderColor = UIColor(named: "greenColor")?.cgColor
    textField.layer.borderWidth = 0.5
    textField.indent(size: 6)
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  
  let descLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "SF Pro", size: 6)
    label.textColor = UIColor(named: "textColor")
    label.isHidden = true
    label.transform = CGAffineTransformMakeScale(0.75, 0.75)
    label.backgroundColor = .systemBackground
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let gender: UISegmentedControl = {
    let segment = UISegmentedControl()
    segment.insertSegment(with: UIImage(named: "male"), at: 0, animated: true)
    segment.insertSegment(with: UIImage(named: "female"), at: 1, animated: true)
    segment.isHidden = true
    segment.layer.cornerRadius = 20
    segment.layer.masksToBounds = true
    segment.selectedSegmentTintColor = UIColor(named: "")
    segment.translatesAutoresizingMaskIntoConstraints = false
    return segment
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(mainTextField)
    contentView.addSubview(descLabel)
    contentView.addSubview(gender)
    mainTextField.delegate = self
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    NSLayoutConstraint.activate([
      mainTextField.topAnchor.constraint(equalTo: self.topAnchor, constant:20),
      mainTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
      mainTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
      mainTextField.heightAnchor.constraint(equalToConstant: 40),
      
      descLabel.leftAnchor.constraint(equalTo: mainTextField.leftAnchor, constant: 6),
      descLabel.topAnchor.constraint(equalTo: mainTextField.topAnchor, constant: -10),
      
      gender.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
      gender.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
      gender.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
      gender.heightAnchor.constraint(equalToConstant: 40)
    ])
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension PetTableViewCell: UITextFieldDelegate {
  func textFieldDidChangeSelection(_ textField: UITextField) {
    if textField.text != ""{
      descLabel.isHidden = false
    } else {
      descLabel.isHidden = true
    }
  }

}
