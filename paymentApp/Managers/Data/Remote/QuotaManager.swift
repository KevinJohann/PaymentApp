//
//  QuotaMethodsManager.swift
//  paymentApp
//
//  Created by Kevin on 09-06-22.
//

import Alamofire

// MARK: - QuotaParameters
struct QuotaParameters: Parameterizable {
    var publicKey: String
    var amount: String
    var paymentMethodId: String
    var issuerId: String

    var asParameters: Parameters {
        [
            "public_key": publicKey,
            "amount": amount,
            "payment_method_id": paymentMethodId,
            "issuer.id": issuerId
        ]
    }
}

// MARK: - QuotaManagerProtocol
protocol QuotaManagerProtocol: AnyObject {
    func getQuota(with parameters: Parameterizable)
}

// MARK: - QuotaManagerOutputProtocol
protocol QuotaManagerOutputProtocol: AnyObject {
    func onQuotaResponse()
    func onQuotaSuccess(response: [Quota])
    func onQuotaFailure()
}

// MARK: - QuotaManager
final class QuotaManager {
    weak var managerOutput: QuotaManagerOutputProtocol?
}

// MARK: - PaymentMethodsProtocol
extension QuotaManager: QuotaManagerProtocol {
    func getQuota(with parameters: Parameterizable) {
        API.call(
            resource: APIRouter.quota(parameters),
            onResponse: { [weak self] in
                guard let self = self else { return }
                self.managerOutput?.onQuotaResponse()
            },
            onSuccess: { [weak self] (response: [Quota]) in
                guard let self = self else { return }
                self.managerOutput?.onQuotaSuccess(response: response)
            },
            onFailure: { [weak self] in
                guard let self = self else { return }
                self.managerOutput?.onQuotaFailure()
            }
        )
    }
}
