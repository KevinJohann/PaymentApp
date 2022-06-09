//
//  AllowedCharsTextField.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//

import UIKit

// MARK: - AllowedCharsTextField
/// - Allows you to define which characters will be accepted in a text field.
/// - Include MaxLengthTextField.
public class AllowedCharsTextField: UITextField, UITextFieldDelegate {
    /// Set allowed chars using interfaz text field component
    @IBInspectable public var allowedChars: String = ""

    /// Set max lenght using interfaz text field component
    @IBInspectable public var maxLength: Int {
        get {
            guard let length = characterLimit else {
                return Int.max
            }
            return length
        }
        set {
            characterLimit = newValue
        }
    }

    private var characterLimit: Int?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        autocorrectionType = .no
    }

    // MARK: - UITextFieldDelegate
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let stringCount = string.count
        guard stringCount > 0 else {
            return true
        }

        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)

        return prospectiveText.count <= maxLength && prospectiveText.containsOnlyCharactersIn(matchCharacters: allowedChars)
    }
}
