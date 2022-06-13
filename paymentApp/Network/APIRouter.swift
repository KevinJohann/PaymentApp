//
//  APIRouter.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//

import Foundation
import Alamofire

// MARK: - Parameterizable
protocol Parameterizable {
    var asParameters: Parameters { get }
}

// MARK: - URLRequestConvertible
enum APIRouter: URLRequestConvertible {
    case paymentMethod(Parameterizable)
    case bankList(Parameterizable)
    case quota(Parameterizable)

    // MARK: - Path as String
    var path: String {
        switch self {
        case .paymentMethod: return "/payment_methods"
        case .bankList: return "/payment_methods/card_issuers"
        case .quota: return "/payment_methods/installments"
        }
    }

    // MARK: - BaseURL
    var baseURL: URL? { APIEnvironment.baseURL }

    // MARK: - URL
    var url: URL? {
        switch APIEnvironment.current {
        case .test: return baseURL?.appendingPathComponent("\(path)")
        }
    }

    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .paymentMethod,
             .bankList,
             .quota: return .get
        }
    }

    // MARK: - Headers
    var headers: HTTPHeaders {
        switch self {
        default: return []
        }
    }

    // MARK: - Parameters
    var parameters: Parameters {
        switch self {
        case .paymentMethod(let parameters),
             .bankList(let parameters),
             .quota(let parameters): return parameters.asParameters
        }
    }
    
    // MARK: - URLRequest
    func asURLRequest() throws -> URLRequest {
        guard let url = url else { return URLRequest(url: URL(string: "")!) }
        
        var urlRequest = URLRequest(url: url)

        defer {
            print("urlRequest: \(urlRequest)")
            print("urlRequest.allHTTPHeaderFields: \(String(describing: urlRequest.allHTTPHeaderFields))")
            print("Parameters: \(parameters)")
        }

        // MARK: - HTTPMethod
        urlRequest.httpMethod = method.rawValue
        
        // MARK: - Parameters Encoding
        switch method {
        case .get: return try URLEncoding.default.encode(urlRequest, with: parameters)
        default: return try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}
