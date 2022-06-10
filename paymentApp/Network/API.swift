//
//  API.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//

import Alamofire

// MARK: - API
enum API {
    @discardableResult
    static func call<T: Decodable>(resource: URLRequestConvertible,
                                   onResponse: CompletionHandler = nil,
                                   onSuccess: SuccessHandler<T> = nil,
                                   onFailure: CompletionHandler = nil) -> DataRequest {
        var jsonDecoder: JSONDecoder {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            return jsonDecoder
        }

        return AF
            .request(resource)
            .responseString(completionHandler: {
                print($0)
            })
            .responseDecodable(decoder: jsonDecoder) { (response: AFDataResponse<T>) in

                if let statusCode = response.response?.statusCode {
                    // Status code handler
                    print(statusCode)
                }

                onResponse?()

                switch response.result {
                case .success(let decodedObject): onSuccess?(decodedObject)
                case .failure(let error):
                    print("error.localizedDescription: \(error.localizedDescription)")
                    onFailure?()
                }
            }
    }
}
