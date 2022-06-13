//
//  PaymentResumeCell.swift
//  paymentApp
//
//  Created by Kevin Torres on 11-06-22.
//

import Foundation
import UIKit

// MARK: - PaymentResumeCell
class PaymentResumeCell: UICollectionViewCell {
    static let reuseIdentifier = "paymentResumeCell"

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
}

// MARK: - Functions
extension PaymentResumeCell {
    func set(textLabel: String) {
        self.textLabel.text = textLabel
    }

    func set(titleLabel: String) {
        self.titleLabel.text = titleLabel
    }
}

// MARK: - PrepareForReuse
extension PaymentResumeCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel.text = ""
        titleLabel.text = ""
    }
}
