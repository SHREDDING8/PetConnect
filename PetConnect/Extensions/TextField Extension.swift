//
//  TextField Extension.swift
//  PetConnect
//
//  Created by SHREDDING on 17.08.2023.
//

import Foundation
import UIKit

extension UITextField {
    
    /// Adding toolbar to textField with done and cancel buttons
    /// - Parameters:
    ///   - onDone: selector that execute after tap on done
    ///   - onCancel: selector that execute after tap on cancel
    ///   - showCancelButton: is show cancel button
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil, showCancelButton:Bool) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = []
        if showCancelButton{
            toolbar.items?.append(UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action))
        }
        toolbar.items?.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        toolbar.items?.append(UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action))
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }

    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
}
