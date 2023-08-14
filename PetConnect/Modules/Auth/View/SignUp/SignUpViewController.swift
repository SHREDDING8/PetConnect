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
    
}

extension SignUpViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.scrollView.setContentOffset(.zero, animated: true)
        textField.resignFirstResponder()
        return true
    }
}

extension SignUpViewController:SignUpViewProtocol{
    
}
