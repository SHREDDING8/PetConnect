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

@IBDesignable
open class CustomTextField: UIView {
    
    let nibName = "CustomTextField"
    
    var delegate:CustomTextFieldDelegate?
    
    @IBOutlet weak var contentView: UIView!
    
    
    // MARK: - Objects
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        initSubviews()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.translatesAutoresizingMaskIntoConstraints = false
        initSubviews()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        initSubviews()
    }
    
    func initSubviews() {
        
        let bundle = Bundle.init(for: CustomTextField.self)
        
        let view = bundle.loadNibNamed(nibName, owner: self)
        let contentView = view?.first as! UIView
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
    }
    
}
