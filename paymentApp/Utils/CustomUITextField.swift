//
//  CustomUITextField.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//

import UIKit

// MARK: - CustomUITextField
class CustomUITextField: UITextField {
   override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
   }
}
