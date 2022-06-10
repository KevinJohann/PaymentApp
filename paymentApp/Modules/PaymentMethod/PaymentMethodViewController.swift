//
//  PaymentMethodViewController.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//  
//

import UIKit

// MARK: - PaymentMethodViewController
final class PaymentMethodViewController: UIViewController {
    @IBOutlet weak var paymentMethodTextField: UITextField!
    @IBOutlet weak var paymentTypeTextField: UITextField!
    @IBOutlet weak var methodImageView: UIImageView! {
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            methodImageView.isUserInteractionEnabled = true
            methodImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.addTarget(self, action: #selector(onContinueButtonPressed(sender:)), for: .touchUpInside)
        }
    }

    private var paymentTypePickerView = UIPickerView()
    private var paymentMethodPickerView = UIPickerView()
    var presenter: PaymentMethodPresenterProtocol?

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.color = .gray

        return activityIndicator
    }()
}

// MARK: - Targets
extension PaymentMethodViewController {
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        paymentMethodTextField.select(nil)
    }

    @objc func onContinueButtonPressed(sender: UIButton) {
        presenter?.onContinueButtonPressed(with: paymentMethodTextField.text ?? "")
    }
}

// MARK: - Life cycles
extension PaymentMethodViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false

        paymentMethodPickerView.delegate = self
        paymentMethodPickerView.dataSource = self
        paymentMethodPickerView.tag = 1
        paymentMethodTextField.inputView = paymentMethodPickerView

        paymentTypePickerView.delegate = self
        paymentTypePickerView.dataSource = self
        paymentTypePickerView.tag = 2
        paymentTypeTextField.inputView = paymentTypePickerView
        
        presenter?.onViewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - PaymentMethodViewProtocol
extension PaymentMethodViewController: PaymentMethodViewProtocol {
    func set(paymentTypes: [PaymentType], and typeId: String) {
        setPaymentMethodImage(with: paymentTypes[0].thumbnail)
        paymentMethodTextField.text = paymentTypes[0].name
        paymentTypeTextField.text = typeId
    }
    
    func startActivityIndicator() {
        view.addSubview(activityIndicator)

        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }

    func stopActivityIndicator() {
        activityIndicator.removeFromSuperview()
    }

    func setPaymentMethodImage(with url: String) {
        guard let url = URL(string: url) else {
            return
        }
        do {
            let data = try Data(contentsOf: url)
            methodImageView.image = UIImage(data: data)
        } catch {
            print("Url Error")
        }
    }
}

// MARK: - UIPickerViewDelegate
extension PaymentMethodViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1: return presenter?.paymentMethodName(by: row, and: paymentTypeTextField.text ?? "")
        case 2: return presenter?.paymentTypeIdName(by: row)
        default: return presenter?.paymentMethodName(by: row, and: paymentTypeTextField.text ?? "")
        }
    }
}

// MARK: - UIPickerViewDataSource
extension PaymentMethodViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1: return presenter?.paymentMethodsCount(by: paymentTypeTextField.text ?? "") ?? 0
        case 2: return presenter?.paymentTypeIdCount() ?? 0
        default: return presenter?.paymentMethodsCount(by: paymentTypeTextField.text ?? "") ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            paymentMethodTextField.text = presenter?.paymentMethodName(by: row, and: paymentTypeTextField.text ?? "")
            paymentMethodTextField.resignFirstResponder()
            setPaymentMethodImage(with: presenter?.paymentMethodUrlImage(by: row, and: paymentTypeTextField.text ?? "") ?? "")
        case 2:
            paymentTypeTextField.text = presenter?.paymentTypeId(by: row)
            paymentMethodTextField.text = presenter?.paymentMethodName(by: 0, and: paymentTypeTextField.text ?? "")
            setPaymentMethodImage(with: presenter?.paymentMethodUrlImage(by: 0, and: paymentTypeTextField.text ?? "") ?? "")
            self.paymentMethodPickerView.selectRow(0, inComponent: 0, animated: false)
            paymentTypeTextField.resignFirstResponder()

        default: return
        }
    }
}
