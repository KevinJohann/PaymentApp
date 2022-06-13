//
//  Quota.swift
//  paymentApp
//
//  Created by Kevin Torres on 11-06-22.
//

import Foundation

// MARK: - Quota
struct Quota: Decodable {
    var paymentMethodId: String
    var paymentTypeId: String
    var payerCosts: [PayerCosts]
}

// MARK: - PayerCosts
struct PayerCosts: Decodable {
    var recommendedMessage: String
}
