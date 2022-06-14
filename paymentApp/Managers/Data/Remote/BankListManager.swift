//
//  BankListManager.swift
//  paymentApp
//
//  Created by Kevin on 09-06-22.
//

import Alamofire

// MARK: - BankListParameters
struct BankListParameters: Parameterizable {
    var publicKey: String
    var paymentMethodId: String

    var asParameters: Parameters {
        [
            "public_key": publicKey,
            "payment_method_id": paymentMethodId
        ]
    }
}

// MARK: - BankListManagerProtocol
protocol BankListManagerProtocol: AnyObject {
    func getBankList(with parameters: Parameterizable)
}

// MARK: - BankListManagerOutputProtocol
protocol BankListManagerOutputProtocol: AnyObject {
    func onGetBankListResponse()
    func onGetBankListSuccess(response: [Bank])
    func onGetBankListFailure()
}

// MARK: - PaymentMethods
final class BankListManager {
    weak var managerOutput: BankListManagerOutputProtocol?
}

// MARK: - BankListManagerProtocol
extension BankListManager: BankListManagerProtocol {
    func getBankList(with parameters: Parameterizable) {
        API.call(
            resource: APIRouter.bankList(parameters),
            onResponse: { [weak self] in
                guard let self = self else { return }
                self.managerOutput?.onGetBankListResponse()
            },
            onSuccess: { [weak self] (response: [Bank]) in
                guard let self = self else { return }
                self.managerOutput?.onGetBankListSuccess(response: response)
            },
            onFailure: { [weak self] in
                guard let self = self else { return }
                self.managerOutput?.onGetBankListFailure()
            }
        )
    }
}
