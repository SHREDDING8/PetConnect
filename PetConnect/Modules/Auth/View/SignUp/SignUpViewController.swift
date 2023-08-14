//
//  SignUpViewController.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var presenter:SignUpPresenterProtocol?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var passwordView: UIView!
    
    @IBOutlet weak var confirmPasswordView: UIView!
    
    @IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavBar()
        configureBorderViews([loginView,emailView,passwordView,confirmPasswordView])
        addKeyboardObservers()
    }
    
    fileprivate func configureNavBar(){
        
        self.navigationItem.title = "Регистрация"
        self.navigationItem.largeTitleDisplayMode = .always
        
    }
    
    fileprivate func configureBorderViews(_ views:[UIView]){
        for view in views {
            view.layer.borderColor = UIColor.black.cgColor
            view.layer.borderWidth = 1
            view.layer.cornerRadius = view.frame.height / 2 - 1
        }
    }
    
    fileprivate func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func keyboardWillShow(notification: NSNotification){

        if let keyboard = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            self.scrollViewBottomConstraint.constant = keyboard.height - 60
        }
        
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        self.scrollViewBottomConstraint.constant = 20
    }
    
    fileprivate func setOpacity(_ view:UIView, opacity:Float){
        UIView.animate(withDuration: 0.3) {
            view.layer.opacity = opacity
        }
    }
    
}

extension SignUpViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.scrollView.setContentOffset(.zero, animated: true)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.restorationIdentifier{
        case "loginTextField":
            self.loginView.layer.borderColor = UIColor(named: "GreetingGreen")?.cgColor
            loginLabel.textColor = UIColor(named: "GreetingGreen") ?? .black
            setOpacity(loginLabel, opacity: 1)
            
        case "emailTextField":
            self.emailView.layer.borderColor = UIColor(named: "GreetingGreen")?.cgColor
            emailLabel.textColor = UIColor(named: "GreetingGreen") ?? .black
            setOpacity(emailLabel, opacity: 1)
            
        case "passwordTextField":
            passwordLabel.textColor = UIColor(named: "GreetingGreen") ?? .black
            setOpacity(passwordLabel, opacity: 1)
            
        case "confirmPasswordTextField":
            self.confirmPasswordView.layer.borderColor = UIColor(named: "GreetingGreen")?.cgColor
            
         default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.restorationIdentifier{
        case "loginTextField":
            presenter?.setLogin(value: textField.text ?? "")
            self.loginView.layer.borderColor = UIColor.black.cgColor
            loginLabel.textColor = .black
            if !textField.hasText{
                setOpacity(loginLabel, opacity: 0)
            }
            
            
        case "emailTextField":
            presenter?.setEmail(value: textField.text ?? "")
            self.emailView.layer.borderColor = UIColor.black.cgColor
            emailLabel.textColor = .black
            if !textField.hasText{
                setOpacity(emailLabel, opacity: 0)
            }
            
            
        case "passwordTextField":
            presenter?.setPassword(value: textField.text ?? "")
            emailLabel.textColor = .black
            if !textField.hasText{
                setOpacity(passwordLabel, opacity: 0)
            }
            
        case "confirmPasswordTextField":
            presenter?.setConfirmPassword(value: textField.text ?? "")
            self.confirmPasswordView.layer.borderColor = UIColor.black.cgColor
            
         default:
            break
        }
        
        presenter?.textFieldChanged()
    }
}

extension SignUpViewController:SignUpViewProtocol{
    func enableRegisrationButton() {
        self.signUpButton.isEnabled = true
    }
    
    func disableRegisrationButton() {
        self.signUpButton.isEnabled = false
    }
    
}
