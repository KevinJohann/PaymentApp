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
    @IBOutlet weak var bankListSelectorTextField: UITextField!
    @IBOutlet weak var bankImageView: UIImageView!
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.addTarget(self, action: #selector(onContinueButtonPressed(sender:)), for: .touchUpInside)
            continueButton.backgroundColor = .lightBlueMercPago
            continueButton.setTitleColor(.white, for: .normal)
            continueButton.layer.cornerRadius = .commonCorner
        }
    }

    private var pickerViews = UIPickerView()
    var presenter: BankSelectionPresenterProtocol?

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

    func setInitialBankImage(with url: String) {
        setBankImage(with: url)
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
        guard let urlImage = presenter?.bankListUrlImage(by: row) else {
            return
        }
        setBankImage(with: urlImage)
        presenter?.setSelectedBankId(by: row)
        bankListSelectorTextField.resignFirstResponder()
    }
}

// MARK: - Private utils
extension BankSelectionViewController {
    func setBankImage(with url: String) {
        guard let url = URL(string: url) else {
            return
        }
        do {
            let data = try Data(contentsOf: url)
            bankImageView.image = UIImage(data: data)
        } catch {
            print("Url Error")
        }
    }    
}
