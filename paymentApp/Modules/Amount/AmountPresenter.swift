//
//  AmountPresenter.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//  
//

// MARK: - AmountPresenter
final class AmountPresenter {
    weak var view: AmountViewProtocol?
    weak var delegate: AmountDelegate?

    var interactor: AmountInteractorProtocol?
    private var transactionData: TransactionDataProtocol?

    init(transactionData: TransactionDataProtocol? = nil) {
        self.transactionData = transactionData
    }
}

// MARK: - AmountPresenterProtocol
extension AmountPresenter: AmountPresenterProtocol {
    func onViewDidLoad() {
        view?.initializeButtonsConfiguration()
        view?.initializeCloseableKeyboard()
        guard let transactionData = transactionData else {
            return
        }
        delegate?.openModal(with: transactionData)
    }
    
    func onContinueButtonPressed(with amountData: String?) {
        guard let amountData = amountData, !amountData.isEmpty else {
            delegate?.onAlertRequested(errorMessage: .noEmptyAmountField)
            return
        }
        guard let amountDataAsInt = Int(amountData), amountDataAsInt >= 1 else {
            delegate?.onAlertRequested(errorMessage: .moreThanZeroText)
            return
        }
        let txData = TransactionData()
        txData.amount = amountData
        delegate?.goToPaymentMethod(with: txData)
    }
}

// MARK: - AmountInteractorOutputProtocol
extension AmountPresenter: AmountInteractorOutputProtocol {}
