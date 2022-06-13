//
//  PaymentResumeViewController.swift
//  paymentApp
//
//  Created by Kevin Torres on 11-06-22.
//

import UIKit

// MARK: - PaymentResumeViewController
final class PaymentResumeViewController: UIViewController {
    @IBOutlet weak var cardView: UIView! {
        didSet {
            cardView.layer.cornerRadius = .commonCorner
        }
    }
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.addTarget(self, action: #selector(onContinueButtonPressed(sender:)), for: .touchUpInside)
            continueButton.backgroundColor = .lightBlueMercPago
            continueButton.setTitleColor(.white, for: .normal)
            continueButton.layer.cornerRadius = .commonCorner
        }
    }
    @IBOutlet weak var resumeCollectionView: UICollectionView!
    @IBOutlet weak var backgroundButton: UIButton! {
        didSet {
            backgroundButton.addTarget(self, action: #selector(onContinueButtonPressed(sender:)), for: .touchUpInside)
        }
    }
    private var dataSource: TransactionDataProtocol? = nil

    func set(dataSource: TransactionDataProtocol) {
        self.dataSource = dataSource
    }
}

// MARK: - Life cycle
extension PaymentResumeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibCell = UINib(nibName: "PaymentCell", bundle: nil)
        resumeCollectionView.register(nibCell, forCellWithReuseIdentifier: PaymentResumeCell.reuseIdentifier)
    }
}

// MARK: - UICollectionViewDelegate
extension PaymentResumeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = cardView.frame.width

        let font = UIFont.systemFont(ofSize: 15)
        let text = getData(by: indexPath.row)

        var height: CGFloat = 32
        switch indexPath.row {
        case 4: height = heightForLabel(text: text, font: font, width: width) * 1.8
        default: height = heightForLabel(text: text, font: font, width: width)
        }
        
        return CGSize(width: width, height: height)
    }
    func heightForLabel(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))

        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()

        return label.frame.height
    }
}

// MARK: - UICollectionViewDataSource
extension PaymentResumeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PaymentResumeCell.reuseIdentifier,
            for: indexPath
        )

        if let paymentResumeCell = cell as? PaymentResumeCell {
            paymentResumeCell.set(textLabel: getData(by: indexPath.row))
            paymentResumeCell.set(titleLabel: getSelectedField(by: indexPath.row))
            return paymentResumeCell
        }
        return cell
    }
}

// MARK: - Targets
extension PaymentResumeViewController {
    @objc func onContinueButtonPressed(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Private utils
extension PaymentResumeViewController {
    private func getData(by row: Int) -> String {
        guard let dataSource = dataSource else { return "" }
        switch row {
        case 0: return dataSource.amount ?? ""
        case 1: return dataSource.paymentMethodId ?? ""
        case 2: return dataSource.paymentTypeCardName ?? ""
        case 3: return dataSource.issuerId ?? ""
        case 4: return dataSource.selectedQuota ?? ""
        default: return ""
        }
    }

    private func getSelectedField(by row: Int) -> String {
        switch row {
        case 0: return "Monto ingresado:"
        case 1: return "Payment method:"
        case 2: return "Card name:"
        case 3: return "issuerId:"
        case 4: return "Cuota:"
        default: return ""
        }
    }
}
