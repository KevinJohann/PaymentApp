//
//  PaymentType.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//

import Foundation

// MARK: - PaymentType
struct PaymentType: Decodable {
    var id: String
    var name: String
    var paymentTypeId: String
    var status: String
    var secureThumbnail: String
    var thumbnail: String
}
