//
//  PaymentMethodsManager.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//

import Alamofire

// MARK: - PaymentMethodsParameters
struct PaymentMethodsParameters: Parameterizable {
    var publicKey: String
    var asParameters: Parameters {
        ["public_key": publicKey]
    }
}

// MARK: - PaymentMethodsProtocol
protocol PaymentMethodsManagerProtocol: AnyObject {
    func getPaymentMethods(with parameters: Parameterizable)
}

// MARK: - PaymentMethodsManagerOutputProtocol
protocol PaymentMethodsManagerOutputProtocol: AnyObject {
    func onPaymentMethodsResponse()
    func onPaymentMethodsSuccess(response: [PaymentType])
    func onPaymentMethodsFailure()
}

// MARK: - PaymentMethods
final class PaymentMethodsManager {
    weak var managerOutput: PaymentMethodsManagerOutputProtocol?
}

// MARK: - PaymentMethodsProtocol
extension PaymentMethodsManager: PaymentMethodsManagerProtocol {
    func getPaymentMethods(with parameters: Parameterizable) {
        API.call(
            resource: APIRouter.paymentMethod(parameters),
            onResponse: {
                self.managerOutput?.onPaymentMethodsResponse()
            },
            onSuccess: { (response: [PaymentType]) in
                self.managerOutput?.onPaymentMethodsSuccess(response: response)
            },
            onFailure: {
                self.managerOutput?.onPaymentMethodsFailure()
            }
        )
    }
}
