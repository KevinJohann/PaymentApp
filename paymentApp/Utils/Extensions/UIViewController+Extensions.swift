//
//  UIViewController+Extensions.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//

import UIKit

// MARK: - Dismiss Keyboard
extension UIViewController {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
}

// MARK: - Alert view
extension UIViewController {
    enum AlertViewTypes {
        case emptyAlert
        case genericError
        case customAlert(title: String, message: String)
        case customMessage(message: String)
    }
    
    func presentAlertView(title: String? = nil, type: AlertViewTypes, acceptAction: ((UIAlertAction) -> Void)? = nil, cancelAction: ((UIAlertAction) -> Void)? = nil) {
        
        var alertTitle: String = .defaultAlertTitle
        var alertMessage: String = .empty
        
        switch (type) {
        case .genericError:
            alertMessage = .defaultAlertMessage
        case .customMessage(let message):
            alertMessage = message
        case .emptyAlert:
            break
        case .customAlert(let title, let message):
            alertTitle = title
            alertMessage = message
        }
        
        let alertController = UIAlertController(
            title: alertTitle,
            message: alertMessage,
            preferredStyle: .alert
        )
        
        alertController.addAction(
            UIAlertAction(
                title: .defaultAcceptActionTitle,
                style: .default,
                handler: acceptAction
            )
        )
        
        if let cancelAction = cancelAction {
            alertController.addAction(
                UIAlertAction(
                    title: .cancel,
                    style: .cancel,
                    handler: cancelAction
                )
            )
        }
        
        applyDefaultAlertStyle(
            alertController: alertController,
            alertTitle: alertTitle,
            alertMessage: alertMessage
        )
        
        self.present(
            alertController,
            animated: true
        )
    }

    func applyDefaultAlertStyle(alertController: UIAlertController, alertTitle: String, alertMessage: String) {
        alertController.view.tintColor = .lightBlueMercPago
        
        let attributedTitle = NSMutableAttributedString(
            string: alertTitle,
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 17),
                .foregroundColor: UIColor(white: 33.0 / 255.0, alpha: 1.0)
            ]
        )
        
        let attributedMessage = NSMutableAttributedString(
            string: alertMessage,
            attributes: [
                .font: UIFont.systemFont(ofSize: 13),
                .foregroundColor: UIColor(white: 33.0 / 255.0, alpha: 1.0)
            ]
        )
        
        alertController.setValue(
            attributedTitle,
            forKey: "attributedTitle"
        )
        
        alertController.setValue(
            attributedMessage,
            forKey: "attributedMessage"
        )
    }
}
