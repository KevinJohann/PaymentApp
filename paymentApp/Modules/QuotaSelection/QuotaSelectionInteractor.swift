//
//  QuotaSelectionInteractor.swift
//  paymentApp
//
//  Created by Kevin on 09-06-22.
//  
//

// MARK: - QuotaSelectionInteractor
final class QuotaSelectionInteractor {
    weak var interactorOutput: QuotaSelectionInteractorOutputProtocol?
    var quotaManager: QuotaManagerProtocol

    required init(quotaManager: QuotaManagerProtocol) {
        self.quotaManager = quotaManager
    }
}

// MARK: - QuotaSelectionInteractorProtocol
extension QuotaSelectionInteractor: QuotaSelectionInteractorProtocol {
    func getQuota(with data: TransactionDataProtocol) {
        guard
            let amount = data.amount,
            let paymentMethodId = data.paymentMethodId,
            let issuerId = data.issuerId else {
            return
        }
        let parameters = QuotaParameters(publicKey: APIEnvironment.publicKey, amount: amount, paymentMethodId: paymentMethodId, issuerId: issuerId)
        quotaManager.getQuota(with: parameters)
    }
}

// MARK: - QuotaManagerOutputProtocol
extension QuotaSelectionInteractor: QuotaManagerOutputProtocol {
    func onQuotaResponse() {
        interactorOutput?.onQuotaResponse()
    }

    func onQuotaSuccess(response: [Quota]) {
        interactorOutput?.onQuotaSuccess(response: response)
    }

    func onQuotaFailure() {
        interactorOutput?.onQuotaFailure()
    }   
}
