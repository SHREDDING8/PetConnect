//
//  PetViewController.swift
//  PetConnect
//
//  Created by Leonid Romanov on 17.08.2023.
//

import UIKit

class PetViewController: UIViewController {
  
  let addPetButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(named: "buttonAdd"), for: .normal)
    button.transform = CGAffineTransformMakeScale(1.3, 1.3)
    return button
  }()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.translatesAutoresizingMaskIntoConstraints = false
    collection.contentInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    collection.isPagingEnabled = true
    collection.register(PetCollectionViewCell.self, forCellWithReuseIdentifier: PetCollectionViewCell.cellID)
    return collection
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    self.title = "Питомцы"
    
    view.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.dataSource = self
    
    view.addSubview(addPetButton)
    addPetButton.addTarget(self, action: #selector(addPet), for: .touchUpInside)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      
      addPetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
      addPetButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
      addPetButton.widthAnchor.constraint(equalToConstant: 60),
      addPetButton.heightAnchor.constraint(equalToConstant: 60)
    ])
    
  }
  
  @objc func addPet() {
    navigationController?.pushViewController(PetCreateViewController(), animated: true)
  }
}

extension PetViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return PetHim.dataSource.count
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width - 32, height: 115)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetCollectionViewCell.cellID, for: indexPath) as! PetCollectionViewCell
        cell.namePet.text = PetHim.dataSource[indexPath.row].name
        cell.porodaLabel.text = PetHim.dataSource[indexPath.row].poroda
        cell.ageLabel.text = PetHim.dataSource[indexPath.row].age
        cell.imageGender.image = UIImage(named: "buttonAdd")
        cell.imagePet.image = UIImage(named: "buttonAdd")
        return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    navigationController?.pushViewController(PetDetailViewController(), animated: true)
  }
}
