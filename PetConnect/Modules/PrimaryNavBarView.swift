//
//  NavBarView.swift
//  PetConnect
//
//  Created by Andrey on 12.08.2023.
//

import UIKit

final class PrimaryNavBarView: UIView {
    
    private lazy var title: UILabel = {
        let element = UILabel()
        element.textColor = UIColor(named: "on-surface")
        element.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var avatar: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(avatarPressed), for: .touchUpInside)
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        backgroundColor = UIColor(named: "NavBarBgColor")
        
        addSubview(title)
        addSubview(avatar)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            avatar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            avatar.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    @objc func avatarPressed() {
        print(#function)
    }
    
    func configure(with text: String, image: UIImage?) {
        title.text = text
        avatar.setImage(image, for: .normal)
    }
}
