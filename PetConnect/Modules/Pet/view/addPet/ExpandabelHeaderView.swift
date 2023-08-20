//
//  ExpandabelHeaderView.swift
//  PetConnect
//
//  Created by Leonid Romanov on 19.08.2023.
//

import UIKit

protocol ExpandabelHeaderViewDelegate {
  func toogleSection(header: ExpandabelHeaderView, section: Int)
}

class ExpandabelHeaderView: UITableViewHeaderFooterView {
  var delegate: ExpandabelHeaderViewDelegate?
  var section: Int?
  
  func setup(withTitle title: String, section: Int, delegate: ExpandabelHeaderViewDelegate) {
    self.delegate = delegate
    self.section = section
    
    self.textLabel?.text = title
  }
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    textLabel?.textColor = .white
    contentView.backgroundColor = .darkGray
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
  @objc func selectHeaderAction(gesterRecognizer: UITapGestureRecognizer) {
    let cell = gesterRecognizer.view as! ExpandabelHeaderView
    delegate?.toogleSection(header: self, section: cell.section!)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
