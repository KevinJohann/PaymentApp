//
//  Bank.swift
//  paymentApp
//
//  Created by Kevin on 09-06-22.
//

import Foundation

// MARK: - Bank
struct Bank: Decodable {
    var id: String
    var name: String
    var secureThumbnail: String
    var thumbnail: String
    var processingMode: String
    var status: String
}
