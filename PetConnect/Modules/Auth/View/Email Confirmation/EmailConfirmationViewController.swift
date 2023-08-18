//
//  EmailConfirmationViewController.swift
//  PetConnect
//
//  Created by SHREDDING on 17.08.2023.
//

import UIKit

class EmailConfirmationViewController: UIViewController {
    
    var presenter:EmailConfirmationPresenterProtocol?
    
    // MARK: - OutLets
    @IBOutlet weak var codeStackView: UIStackView!
    
    @IBOutlet weak var firstDigitTextField: UITextField!
    
    @IBOutlet weak var secondDigitTextField: UITextField!
    
    @IBOutlet weak var thirdDigitTextField: UITextField!
    
    @IBOutlet weak var fourthDigitTextField: UITextField!
    
    
    @IBOutlet weak var confirmButton: UIButton!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        
        let codeStackViewTap = UITapGestureRecognizer(target: self, action: #selector(codeTapped))
        codeStackView.addGestureRecognizer(codeStackViewTap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.firstDigitTextField.becomeFirstResponder()
    }
    
    
    /// configure passCode text field
    fileprivate func configureTextFields(){
        
        self.firstDigitTextField.addTarget(self, action: #selector(textFieldDidChange) , for: .editingChanged)
        self.secondDigitTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.thirdDigitTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.fourthDigitTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    /// handle the tap to stack view
    @objc func codeTapped(){
        self.firstDigitTextField.isUserInteractionEnabled = true
        self.firstDigitTextField.becomeFirstResponder()
        
        self.firstDigitTextField.text = ""
        self.secondDigitTextField.text = ""
        self.thirdDigitTextField.text = ""
        self.fourthDigitTextField.text = ""
        presenter?.passCode = []
        self.confirmButton.isEnabled = false
    }
    
    /// handle changing text fields
    @objc func textFieldDidChange(){
        if firstDigitTextField.isFirstResponder{
            if firstDigitTextField.hasText{
                nextTextField(textField: firstDigitTextField, nextTextField: secondDigitTextField)
                if let digit = Int(firstDigitTextField.text ?? ""){
                    presenter?.passCode.append(digit)
                }
               
            }
        }else if secondDigitTextField.isFirstResponder{
            if secondDigitTextField.hasText{
                nextTextField(textField: secondDigitTextField, nextTextField: thirdDigitTextField)
                if let digit = Int(secondDigitTextField.text ?? ""){
                    presenter?.passCode.append(digit)
                }
            }
        }else if thirdDigitTextField.isFirstResponder{
            if thirdDigitTextField.hasText{
                nextTextField(textField: thirdDigitTextField, nextTextField: fourthDigitTextField)
                if let digit = Int(thirdDigitTextField.text ?? ""){
                    presenter?.passCode.append(digit)
                }
            }
        }else if fourthDigitTextField.isFirstResponder{
            if fourthDigitTextField.hasText{
                nextTextField(textField: fourthDigitTextField, nextTextField: nil)
                if let digit = Int(fourthDigitTextField.text ?? ""){
                    presenter?.passCode.append(digit)
                }
            }
        }
        if presenter?.passCode.count == 4{
            self.confirmButton.isEnabled = true
        }
    }
    
    
    @IBAction func confirmTapped(_ sender: Any) {
        presenter?.confirmTapped()
    }
    
    @IBAction func resendTapped(_ sender: Any) {
        presenter?.resendTapped()
    }
    
    
    /// set up next textfield
    /// - Parameters:
    ///   - textField: current TextField
    ///   - nextTextField: will setup TextField
    fileprivate func nextTextField(textField:UITextField, nextTextField:UITextField?){
        if let next = nextTextField{
            next.isUserInteractionEnabled = true
            next.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        textField.isUserInteractionEnabled = false
    }
    
}

extension EmailConfirmationViewController:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if "0123456789".contains(string){
            return true
        }else{
            return false
        }
    }
    
}

extension EmailConfirmationViewController:EmailConfirmationViewProtocol{
    func confirmationError() {
        let alert = UIAlertController(title: "Ошибка подтверждения", message: "Повторите попытку", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ок", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    func confrimationOk() {
        
        MainBuilder.setMainWindow(window: view.window)
        
    }
    
    func resendOk() {
        let alert = UIAlertController(title: "Код подтверждения был отправлен на почту", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ок", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    func resendError() {
        let alert = UIAlertController(title: "Ошибка отправки кода подтверждения", message: "Повторите попытку", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ок", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    
}
