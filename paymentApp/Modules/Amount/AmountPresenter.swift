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
    var interactor: AmountInteractorProtocol?
    weak var delegate: AmountDelegate?
}

// MARK: - AmountPresenterProtocol
extension AmountPresenter: AmountPresenterProtocol {
    func onViewDidLoad() {
        view?.initializeButtonsConfiguration()
        view?.initializeCloseableKeyboard()
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
        delegate?.goToPaymentMethod(with: amountData)
    }
}

// MARK: - AmountInteractorOutputProtocol
extension AmountPresenter: AmountInteractorOutputProtocol {}
