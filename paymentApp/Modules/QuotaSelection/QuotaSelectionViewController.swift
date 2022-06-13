//
//  QuotaSelectionViewController.swift
//  paymentApp
//
//  Created by Kevin on 09-06-22.
//  
//

import UIKit

// MARK: - QuotaSelectionViewController
final class QuotaSelectionViewController: UIViewController {
    @IBOutlet weak var quotaTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.backgroundColor = .lightBlueMercPago
            continueButton.setTitleColor(.white, for: .normal)
            continueButton.layer.cornerRadius = .commonCorner
            continueButton.addTarget(self, action: #selector(onContinueButtonPressed(sender:)), for: .touchUpInside)
        }
    }
    private var pickerViews = UIPickerView()
    var presenter: QuotaSelectionPresenterProtocol?

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.color = .gray

        return activityIndicator
    }()
}

// MARK: - Target
extension QuotaSelectionViewController {
    @objc func onContinueButtonPressed(sender: UIButton) {
        presenter?.onContinueButtonPressed()
    }
}

// MARK: - Life cycles
extension QuotaSelectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViews.delegate = self
        pickerViews.dataSource = self
        quotaTextField.inputView = pickerViews

        let backItem = UIBarButtonItem()
        backItem.tintColor = .lightBlueMercPago
        backItem.title = "Volver"
        self.navigationItem.backBarButtonItem = backItem

        presenter?.onViewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - QuotaSelectionViewProtocol
extension QuotaSelectionViewController: QuotaSelectionViewProtocol {
    func startActivityIndicator() {
        view.addSubview(activityIndicator)

        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }

    func stopActivityIndicator() {
        activityIndicator.removeFromSuperview()
    }

    
    func set(firstQuota: String) {
        quotaTextField.text = firstQuota
    }
}

// MARK: - UIPickerViewDelegate
extension QuotaSelectionViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        presenter?.quotaText(by: row)
    }
}

// MARK: - UIPickerViewDataSource
extension QuotaSelectionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        presenter?.payersCostsDataCount() ?? 0
    }
 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let selectedQuotaText = presenter?.quotaText(by: row) else {
            return
        }
        quotaTextField.text = selectedQuotaText
        presenter?.update(selectedQuotaText: selectedQuotaText)
        quotaTextField.resignFirstResponder()
    }
}
