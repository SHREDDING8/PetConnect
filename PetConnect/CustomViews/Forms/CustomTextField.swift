//
//  TextField.swift
//  PetConnect
//
//  Created by SHREDDING on 19.08.2023.
//

import UIKit

// MARK: - delegate protocol
@objc protocol CustomTextFieldDelegate{
    @objc optional func textFieldDidChange()
    @objc optional func textFieldShouldReturn()
}

@IBDesignable
open class CustomTextField: UIView {
    
    let nibName = "CustomTextField"
    
    var delegate:CustomTextFieldDelegate?
    
    // MARK: - @IBOutlets
    @IBOutlet private weak var contentView: UIView!
    
    @IBOutlet private weak var borderView: UIView!
    
    @IBOutlet private weak var upperLabelView: UIView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet private weak var upperLabel: UILabel!
    
    @IBOutlet private weak var supportingLabel: UILabel!
    
    // MARK: - Properties
    
    open var cornerRadius: CGFloat {
        get {
            return self.borderView.layer.cornerRadius
        }
        set {
            self.borderView.layer.cornerRadius = newValue
        }
    }
    
    open var textFieldBackgroundColor: UIColor?{
        get{
            return self.borderView.backgroundColor
        }
        set{
            self.borderView.backgroundColor = newValue
            self.textField.backgroundColor = newValue
        }
    }
    open var textColor:UIColor = .black
    open var focusedColor:UIColor? = UIColor(named: "GreetingGreen")
    open var wrongValueColor:UIColor? = UIColor(named: "WrongValue")
    
    open var showUpperLabelWhenTextFieldIsEmpty:Bool = false
    open var showUpperLabelWhenTextFieldIsNotEmty:Bool = true
    
    open var placeholder:String = "" {
        didSet{
            self.textField.placeholder = placeholder
        }
    }
    open var upperText:String = ""{
        didSet{
            self.upperLabel.text = upperText
        }
    }
    
    open var supportingText:String = ""{
        didSet{
            self.supportingLabel.text = supportingText
        }
    }
    
    init(cornerRadius:CGFloat){
        super.init(frame: CGRectZero)
        self.cornerRadius = cornerRadius
        self.viewInit()
    }
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        viewInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.translatesAutoresizingMaskIntoConstraints = false
        viewInit()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        viewInit()
    }
    
    private func viewInit(){
        initSubviews()
        configureBorder()
        textFieldInit()
    }
    
    private func initSubviews() {
        
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
    
    private func configureBorder(){
        self.borderView.layer.borderColor = UIColor.black.cgColor
        self.borderView.layer.borderWidth = 1
        self.borderView.layer.cornerRadius = cornerRadius
//        self.borderView.layer.masksToBounds = true
    }
    
    private func textFieldInit(){
        self.textField.delegate = self
        self.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    
    // MARK: - Actions
    
    @objc private func textFieldDidChange(){
        delegate?.textFieldDidChange?()
    }
    
    func showUpperText(){
        UIView.animate(withDuration: 0.3) {
            self.upperLabel.layer.opacity = 1
        }
    }
    
    func hideUpperText(){
        UIView.animate(withDuration: 0.3) {
            self.upperLabel.layer.opacity = 0
        }
    }
}

extension CustomTextField:UITextFieldDelegate{
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.borderView.layer.borderColor = textColor.cgColor
        self.upperLabel.textColor = textColor
        
        if !self.showUpperLabelWhenTextFieldIsNotEmty && textField.hasText{
            self.hideUpperText()
        }
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.showUpperText()
        self.borderView.layer.borderColor = focusedColor?.cgColor
        self.upperLabel.textColor = focusedColor
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        delegate?.textFieldShouldReturn?()
        return true
    }
    
}
