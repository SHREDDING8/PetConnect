//
//  GreetingViewController.swift
//  PetConnect
//
//  Created by SHREDDING on 13.08.2023.
//

// MARK: - TODO
// Настроить шрифты

import UIKit

class GreetingViewController: UIViewController {
    var presenter:GreetingPresenterProtocol?
    
    @IBOutlet weak var appTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
}

extension GreetingViewController:GreetingViewProtocol{
    
}
