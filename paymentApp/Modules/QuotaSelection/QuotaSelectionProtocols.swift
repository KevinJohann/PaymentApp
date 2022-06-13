//
//  QuotaSelectionProtocols.swift
//  paymentApp
//
//  Created by Kevin on 09-06-22.
//  
//

import UIKit

// MARK: - View
protocol QuotaSelectionViewProtocol: AnyObject {
    func startActivityIndicator()
    func stopActivityIndicator()
    func set(firstQuota: String)
}

// MARK: - Interactor
protocol QuotaSelectionInteractorProtocol: AnyObject {
    func getQuota(with data: TransactionDataProtocol)
}

// MARK: - InteractorOutput
protocol QuotaSelectionInteractorOutputProtocol: AnyObject {
    func onQuotaResponse()
    func onQuotaSuccess(response: [Quota])
    func onQuotaFailure()
}

// MARK: - Presenter
protocol QuotaSelectionPresenterProtocol: AnyObject {
    func onViewDidLoad()
    func onContinueButtonPressed()
    func quotaText(by position: Int) -> String
    func payersCostsDataCount() -> Int
    func update(selectedQuotaText: String)
}
