//
//  TextField.swift
//  PetConnect
//
//  Created by SHREDDING on 19.08.2023.
//

import UIKit

// MARK: - delegate protocol
@objc protocol CustomTextFieldDelegate{
    @objc optional func textFieldDidChange(_ textField: UITextField)
    @objc optional func textFieldShouldReturn(_ textField: UITextField)
    @objc optional func textFieldDidEndEditing(_ textField: UITextField)
    @objc optional func textFieldDidBeginEditing(_ textField: UITextField)
}

@IBDesignable
open class CustomTextField: UIView {
    
    let nibName = "CustomTextField"
    
    var delegate:CustomTextFieldDelegate?
    
    // MARK: - @IBOutlets
    private weak var contentView: UIView!
    
    @IBOutlet private weak var borderView: UIView!
    
    @IBOutlet private weak var upperLabelView: UIView!
    
    @IBOutlet private weak var textField: UITextField!
    
    @IBOutlet private weak var upperLabel: UILabel!
    
    @IBOutlet private weak var supportingLabel: UILabel!
    
    // MARK: - Properties
    
    @IBInspectable
    open var text: String = "" {
        didSet{
            self.textField.text = text
        }
    }
    @IBInspectable
    open var cornerRadius: CGFloat = 0 {
        didSet{
            self.borderView.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    open var placeholder:String = ""
    @IBInspectable
    open var upperText:String = ""{
        didSet{
            self.upperLabel.text = upperText
        }
    }
    
    @IBInspectable
    open var supportingText:String = ""{
        didSet{
            self.supportingLabel.text = supportingText
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
    
    open var isEnabled:Bool = true {
        didSet{
            if isEnabled{
                self.enable()
            }else{
                self.disable()
            }
        }
    }
    
    init(cornerRadius:CGFloat, upperText:String, textFieldPlaceholder:String, supportingText:String){
        super.init(frame: CGRectZero)
        self.cornerRadius = cornerRadius
        self.upperText = upperText
        self.placeholder = textFieldPlaceholder
        self.supportingText = supportingText
        self.commonInit()
    }
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.translatesAutoresizingMaskIntoConstraints = false
        commonInit()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    // MARK: - Funcs during Init
    private func commonInit(){
        self.contentView = initFromNib()
        setSubviews()
        setConstraints()
        setInspectableValues()
        configureBorder()
        textFieldInit()
        configureUpperLabel()
        isEnabled = false
    }
    private func initFromNib()->UIView{
        let bundle = Bundle.init(for: CustomTextField.self)
        let view = bundle.loadNibNamed(nibName, owner: self)
        let contentView = view?.first as! UIView
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.frame = bounds
        return contentView
    }
    private func setSubviews(){
        addSubview(contentView)
    }
    private func setConstraints(){
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    private func setInspectableValues(){
        self.borderView.layer.cornerRadius = self.cornerRadius
        self.upperLabel.text = upperText
        self.supportingLabel.text = supportingText
        self.textField.placeholder = self.placeholder
    }
    private func configureBorder(){
        self.borderView.layer.borderColor = UIColor.black.cgColor
        self.borderView.layer.borderWidth = 1
        self.borderView.layer.masksToBounds = true
    }
    private func textFieldInit(){
        self.textField.delegate = self
        self.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.textField.tintColor = .black
    }
    private func configureUpperLabel(){
        if showUpperLabelWhenTextFieldIsEmpty{
            self.upperLabelView.layer.opacity = 1
        }else{
            self.upperLabelView.layer.opacity = 0
        }
    }
    private func enable(){
        self.textField.isUserInteractionEnabled = true
        self.contentView.layer.opacity = 1
        self.borderView.layer.borderColor = UIColor.black.cgColor
    }
    
    private func disable(){
        self.textField.isUserInteractionEnabled = false
        self.contentView.layer.opacity = 0.3
        self.borderView.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    
    // MARK: - Actions
    
    @objc private func textFieldDidChange(){

        self.text = self.textField.text ?? ""
        delegate?.textFieldDidChange?(textField)
    }
    
    func showUpperText(){
        UIView.animate(withDuration: 0.3) {
            self.upperLabelView.layer.opacity = 1
        }
    }
    
    func hideUpperText(){
        UIView.animate(withDuration: 0.3) {
            self.upperLabelView.layer.opacity = 0
        }
    }
    
    func setWrongValue(){
        self.borderView.layer.borderColor = self.wrongValueColor?.cgColor
        self.upperLabel.textColor = self.wrongValueColor
        self.supportingLabel.textColor = self.wrongValueColor
        self.textField.tintColor = self.wrongValueColor
        
    }
}

extension CustomTextField:UITextFieldDelegate{
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.borderView.layer.borderColor = textColor.cgColor
        self.upperLabel.textColor = textColor
        self.supportingLabel.textColor = textColor
        
        if !self.showUpperLabelWhenTextFieldIsEmpty && !textField.hasText{
            self.hideUpperText()
        }
        
        if !self.showUpperLabelWhenTextFieldIsNotEmty && textField.hasText{
            self.hideUpperText()
        }
        delegate?.textFieldDidEndEditing?(textField)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.showUpperText()
        self.borderView.layer.borderColor = focusedColor?.cgColor
        self.upperLabel.textColor = focusedColor
        
        delegate?.textFieldDidBeginEditing?(textField)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        delegate?.textFieldShouldReturn?(textField)
        return true
    }
    
}
