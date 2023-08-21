//
//  PetCreatePageViewController.swift
//  PetConnect
//
//  Created by Leonid Romanov on 17.08.2023.
//

import UIKit

class PetCreateViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    self.title = "Добавить питомца"
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    
    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.hideKeyboardOnSwipeDown))
    swipeDown.delegate = self
    swipeDown.direction = UISwipeGestureRecognizer.Direction.down
    view.addGestureRecognizer(swipeDown)
  }
  
  //MARK: Keyboard
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    subscribeKeyboardEvents()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  func subscribeKeyboardEvents() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                           name:UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                           name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc func keyboardWillShow(_ notification: NSNotification) {
    guard let ks = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                    as? NSValue)?.cgRectValue else { return }
    tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ks.height - self.view.safeAreaInsets.bottom + 20, right: 0)
  }
  
  @objc func keyboardWillHide(_ notrification: NSNotification) {
    tableView.contentInset = .zero
  }
  
  @objc func hideKeyboardOnSwipeDown() {
    view.endEditing(true)
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
  //MARK: - tableView
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return TableInfo.dataSource.count + 1
    } else {
      return Section.dataSource[section-1].description.count
    }
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      if indexPath.row == 4 {
        let cell = PetTableViewCell()
        cell.mainTextField.isHidden = true
        cell.gender.isHidden = false
        return cell
      }
      let cell = PetTableViewCell()
      cell.descLabel.text = TableInfo.dataSource[indexPath.row].text
      cell.mainTextField.placeholder = cell.descLabel.text
      return cell
    } else {
      let cell = PetTableViewCell()
      cell.descLabel.text = Section.dataSource[indexPath.section-1].description[indexPath.row]
      cell.mainTextField.placeholder = cell.descLabel.text
      return cell
    }
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if section == 0 {
      return nil
    }
    let header = ExpandabelHeaderView()
    header.setup(withTitle: Section.dataSource[section-1].nameSection, section: section-1, delegate: self)
    return header
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return 60
    } else {
      if Section.dataSource[indexPath.section-1].isExpanded {
        return 100
      } else {
        return 0
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return section == 0 ? 0 : 44
  }
}

extension PetCreateViewController: ExpandabelHeaderViewDelegate {
  func toogleSection(header: ExpandabelHeaderView, section: Int) {
    Section.dataSource[section].isExpanded.toggle()
    
    tableView.beginUpdates()
    for row in 0..<Section.dataSource[section].description.count {
      tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
    }
    tableView.endUpdates()
  }
}

extension PetCreateViewController: UIGestureRecognizerDelegate {
  
}
