//
//  APIEnvironment.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//

import Foundation

// MARK: - APIEnvironment
enum APIEnvironment {
    case test

    static var current: APIEnvironment { .test }

    static var baseURL: URL? {
        var baseURLAsString: String {
            switch current {
            case .test: return "https://api.mercadopago.com/v1"
            }
        }

        return URL(string: baseURLAsString)
    }

    static var publicKey = "444a9ef5-8a6b-429f-abdf-587639155d88"
}
