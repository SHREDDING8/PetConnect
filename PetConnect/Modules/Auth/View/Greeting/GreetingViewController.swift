//
//  GreetingViewController.swift
//  PetConnect
//
//  Created by SHREDDING on 13.08.2023.
//

import UIKit

class GreetingViewController: UIViewController {
    var presenter:GreetingPresenterProtocol?
    
    @IBOutlet weak var appTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .never
        setAppName()
        
        
        
    }
    
    fileprivate func setAppName(){
        
        let appTitleString = NSMutableAttributedString(
            string: "Pet",
            attributes: [
                .foregroundColor : UIColor.black,
                .font : UIFont(name: "SFProDisplay-Regular", size: 34)!
            ]
        )
        
        appTitleString.append(
            NSAttributedString(
                string: "Connect",
                attributes: [
                    .foregroundColor : UIColor(named: "GreetingGreen")!,
                    .font : UIFont(name: "SFProDisplay-Regular", size: 34)!
                ]
            )
        )
        
        self.appTitle.attributedText = appTitleString
    }
    
    // MARK: - Actions
    
    @IBAction func signInTapped(_ sender: UIButton) {
        
        let signInController = AuthBuilder.createSignInPage()
        self.navigationController?.pushViewController(signInController, animated: true)
        
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        
//        let signUpController = AuthBuilder.createSignUpPage()
//        self.navigationController?.pushViewController(signUpController, animated: true)
        
        let controller = AuthBuilder.createEmailConfirmationPage(email: "test", password: "test")
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
}

extension GreetingViewController:GreetingViewProtocol{
    
}
