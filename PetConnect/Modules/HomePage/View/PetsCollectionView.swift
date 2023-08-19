//
//  PetsCollectionView.swift
//  PetConnect
//
//  Created by Andrey on 13.08.2023.
//

import Foundation
import UIKit

protocol SelectCollectionViewItemProtocol: AnyObject {
    func selectItem(index: IndexPath)
}

class PetsCollectionView: UICollectionView {
    
    private let categoryLayout = UICollectionViewFlowLayout()
    var pets: [Pet] = []
    
    weak var cellDelegate: SelectCollectionViewItemProtocol?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: categoryLayout)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        categoryLayout.minimumInteritemSpacing = 16
        categoryLayout.scrollDirection = .horizontal
        
        backgroundColor = .none
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        
        delegate = self
        dataSource = self
        
//        selectItem(at: [0,0], animated: true, scrollPosition: [])
        self.register(PetsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}

//MARK: - UICollectionViewDataSource
extension PetsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PetsCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.nameLabel.text = pets[indexPath.item].name
        cell.photoImageView.image = pets[indexPath.item].photo
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension PetsCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        cellDelegate?.selectItem(index: indexPath)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PetsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: collectionView.frame.height)
    }
}
