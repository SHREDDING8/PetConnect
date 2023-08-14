//
//  SignInViewController.swift
//  PetConnect
//
//  Created by SHREDDING on 14.08.2023.
//

import UIKit

class SignInViewController: UIViewController {
    
    var presenter:SignInPresenterProtocol?
    
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var passwordView: UIView!
    
    @IBOutlet weak var loginFocusedLabel: UILabel!
    
    @IBOutlet weak var passwordFocusedLabel: UILabel!
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var wrongPasswordLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureBorderViews([loginView, passwordView])
        
    }
    
    fileprivate func configureNavBar(){
        
        self.navigationItem.title = "Вход"
        self.navigationItem.largeTitleDisplayMode = .always
        
    }
    
    fileprivate func configureBorderViews(_ views:[UIView]){
        for view in views {
            view.layer.borderColor = UIColor.black.cgColor
            view.layer.borderWidth = 1
            view.layer.cornerRadius = view.frame.height / 2 - 1
        }
    }
    
    fileprivate func setOpacityLabel(_ label:UILabel, opacity:Float){
        UIView.animate(withDuration: 0.3) {
            label.layer.opacity = opacity
        }
    }
    
}

extension SignInViewController:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.restorationIdentifier{
        case "loginTextField":
            loginView.layer.borderColor = UIColor(named: "GreetingGreen")?.cgColor
            setOpacityLabel(loginFocusedLabel, opacity: 1)
            loginFocusedLabel.textColor = UIColor(named: "GreetingGreen")
        case "passwordTextField":
            passwordView.layer.borderColor = UIColor(named: "GreetingGreen")?.cgColor
            setOpacityLabel(passwordFocusedLabel, opacity: 1)
        case .none:
            break
        case .some(_):
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.restorationIdentifier{
        case "loginTextField":
            loginView.layer.borderColor = UIColor.black.cgColor
            if (textField.text?.isEmpty ?? true){
                setOpacityLabel(loginFocusedLabel, opacity: 0)
            }else{
                self.loginFocusedLabel.textColor = .black
            }
            presenter?.setSignInData(type: .login, value: textField.text ?? "")
        case "passwordTextField":
            passwordView.layer.borderColor = UIColor.black.cgColor
            setOpacityLabel(passwordFocusedLabel, opacity: 0)
            presenter?.setSignInData(type: .password, value: textField.text ?? "")
            
        case .none:
            break
        case .some(_):
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}

extension SignInViewController: SignInViewProtocol{
    func enableLogInButton() {
        self.logInButton.isEnabled = true
    }
    
    func disableLogInButton() {
        self.logInButton.isEnabled = false
    }
    
}
