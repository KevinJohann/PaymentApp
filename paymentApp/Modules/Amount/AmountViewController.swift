//
//  AmountViewController.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//  
//

import UIKit

// MARK: - AmountViewController
final class AmountViewController: UIViewController {
    var presenter: AmountPresenterProtocol?
    
    // FIXME: - Improve adding currency symbol
    @IBOutlet weak var amountTextField: AllowedCharsTextField! {
        didSet {
            amountTextField.keyboardType = .numberPad
        }
    }

    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.addTarget(
                self,
                action: #selector(onBackButtonPressed(sender:)),
                for: .touchUpInside
            )
        }
    }
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.addTarget(
                self,
                action: #selector(onContinueButtonPressed(sender:)),
                for: .touchUpInside
            )
        }
    }
}

// MARK: - Life cycles
extension AmountViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
    }
}

// MARK: - Targets
extension AmountViewController {
    @objc func onContinueButtonPressed(sender: UIButton) {
        presenter?.onContinueButtonPressed(with: amountTextField.text)
    }

    @objc func onBackButtonPressed(sender: UIButton) {
        amountTextField.text = .empty
    }
}

// MARK: - AmountViewProtocol
extension AmountViewController: AmountViewProtocol {
    func initializeButtonsConfiguration() {
        backButton.backgroundColor = .lightBlueMercPago
        backButton.setTitleColor(.white, for: .normal)
        backButton.layer.cornerRadius = 8
        
        continueButton.backgroundColor = .lightBlueMercPago
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.layer.cornerRadius = 8
    }
    
    func initializeCloseableKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
}