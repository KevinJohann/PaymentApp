//
//  TestUtils.swift
//  paymentAppTests
//
//  Created by Kevin on 13-06-22.
//

import Foundation

extension String {
    func encodeToJson(using encoding: Encoding = .utf8) -> [String: Any] {
        guard
            let data = data(using: encoding),
            let object = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return [:]
        }
        return object
    }
}

