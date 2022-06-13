//
//  QuotaSelectionPresenter.swift
//  paymentApp
//
//  Created by Kevin on 09-06-22.
//  
//

// MARK: - QuotaSelectionPresenter
final class QuotaSelectionPresenter {
    weak var view: QuotaSelectionViewProtocol?
    weak var delegate: QuotaSelectionDelegate?

    var interactor: QuotaSelectionInteractorProtocol?
    var quotaDataSource: [Quota]? {
        didSet {
            guard let quotaDataSource = quotaDataSource else {
                return
            }
            quotaDataSource.forEach {
                $0.payerCosts.forEach {
                    self.payersCostsData.append($0.recommendedMessage)
                }
            }
            guard let firstQuota = payersCostsData.first, !firstQuota.isEmpty else {
                print("Data error, no quota to show")
                return
            }
            selectedQuota = firstQuota
            view?.set(firstQuota: firstQuota)
        }
    }
    var payersCostsData = [String]()
    var selectedQuota: String?
    private let transactionData: TransactionDataProtocol

    init(transactionData: TransactionDataProtocol) {
        self.transactionData = transactionData
    }
}

// MARK: - QuotaSelectionPresenterProtocol
extension QuotaSelectionPresenter: QuotaSelectionPresenterProtocol {
    func onViewDidLoad() {
        view?.startActivityIndicator()
        interactor?.getQuota(with: transactionData)
    }
    
    func onContinueButtonPressed() {
        var updatedTransactionData = transactionData
        updatedTransactionData.selectedQuota = selectedQuota
        delegate?.goToRootView(with: updatedTransactionData)
    }

    func quotaText(by position: Int) -> String {
        payersCostsData[position]
    }

    func payersCostsDataCount() -> Int {
        return payersCostsData.count
    }

    func update(selectedQuotaText: String) {
        selectedQuota = selectedQuotaText
    }
}

// MARK: - QuotaSelectionInteractorOutputProtocol
extension QuotaSelectionPresenter: QuotaSelectionInteractorOutputProtocol {
    func onQuotaResponse() {
        view?.stopActivityIndicator()
    }

    func onQuotaSuccess(response: [Quota]) {
        quotaDataSource = response
    }

    func onQuotaFailure() {
        delegate?.onErrorView(with: "Ha ocurrido un error, te redirigiremos al comienzo")
    }
}
