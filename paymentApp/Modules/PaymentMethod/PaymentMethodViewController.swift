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
    @IBOutlet weak var pickerTextField: UITextField!
    @IBOutlet weak var methodImageView: UIImageView! {
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            methodImageView.isUserInteractionEnabled = true
            methodImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }

    private var pickerView = UIPickerView()
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
        pickerTextField.select(nil)
    }
}

// MARK: - Life cycles
extension PaymentMethodViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
        pickerTextField.inputView = pickerView

        presenter?.onViewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - PaymentMethodViewProtocol
extension PaymentMethodViewController: PaymentMethodViewProtocol {
    func set(paymentTypes: [PaymentType]) {
        setPaymentMethodImage(with: paymentTypes[0].thumbnail)
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
        presenter?.paymentMethodName(by: row)
    }
}

// MARK: - UIPickerViewDataSource
extension PaymentMethodViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        presenter?.paymentMethodsCount() ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = presenter?.paymentMethodName(by: row)
        pickerTextField.resignFirstResponder()
        setPaymentMethodImage(with: presenter?.paymentMethodUrlImage(by: row) ?? "") // Set No Image url
    }
}
