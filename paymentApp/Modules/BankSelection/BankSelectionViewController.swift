//
//  BankSelectionViewController.swift
//  paymentApp
//
//  Created by Kevin on 09-06-22.
//  
//

import UIKit

// MARK: - BankSelectionViewController
final class BankSelectionViewController: UIViewController {
    var presenter: BankSelectionPresenterProtocol?
    @IBOutlet weak var bankListSelectorTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.addTarget(self, action: #selector(onContinueButtonPressed(sender:)), for: .touchUpInside)
        }
    }
    private var pickerViews = UIPickerView()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.color = .gray

        return activityIndicator
    }()
}

// MARK: - Target
extension BankSelectionViewController {
    @objc func onContinueButtonPressed(sender: UIButton) {
        presenter?.onContinueButtonPressed()
    }
}

// MARK: - Life cycles
extension BankSelectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViews.delegate = self
        pickerViews.dataSource = self
        bankListSelectorTextField.inputView = pickerViews
        presenter?.onViewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - BankSelectionViewProtocol
extension BankSelectionViewController: BankSelectionViewProtocol {
    func startActivityIndicator() {
        view.addSubview(activityIndicator)

        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }

    func stopActivityIndicator() {
        activityIndicator.removeFromSuperview()
    }

    func set(bankName: String) {
        bankListSelectorTextField.text = bankName
    }
}

// MARK: - UIPickerViewDelegate
extension BankSelectionViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        presenter?.bankName(by: row)
    }
}

// MARK: - UIPickerViewDataSource
extension BankSelectionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        presenter?.bankListCount() ?? 0
    }
 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bankListSelectorTextField.text = presenter?.bankName(by: row)
    }
}
