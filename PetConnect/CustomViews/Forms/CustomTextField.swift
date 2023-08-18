//
//  TextField.swift
//  PetConnect
//
//  Created by SHREDDING on 19.08.2023.
//

import UIKit

// MARK: - delegate protocol
protocol CustomTextFieldDelegate{
    
}

class CustomTextField: UIView {
    
    var delegate:CustomTextFieldDelegate?
    
    // MARK: - Objects
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
