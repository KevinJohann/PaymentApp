//
//  BankSelectionPresenter.swift
//  paymentApp
//
//  Created by Kevin on 09-06-22.
//  
//

import UIKit

// MARK: - BankSelectionPresenter
final class BankSelectionPresenter {
    weak var view: BankSelectionViewProtocol?
    weak var delegate: BankSelectionDelegate?

    var interactor: BankSelectionInteractorProtocol?
    private let transactionData: TransactionDataProtocol
    private var selectedBankId: String?
    
    private var bankList: [Bank]? {
        didSet {
            guard let bankList = bankList, let firstBank = bankList.first else {
                // Catch, make something
                return
            }
            selectedBankId = firstBank.id
            view?.set(bankName: firstBank.name)
            view?.setInitialBankImage(with: firstBank.secureThumbnail)
        }
    }
    init(transactionData: TransactionDataProtocol) {
        self.transactionData = transactionData
    }
}

// MARK: - BankSelectionPresenterProtocol
extension BankSelectionPresenter: BankSelectionPresenterProtocol {
    func onViewDidLoad() {
        view?.startActivityIndicator()

        guard let paymentId = transactionData.paymentMethodId else {
            return
        }
        interactor?.onGetBankList(with: paymentId)
    }
    
    func bankName(by position: Int) -> String {
        guard let bankList = bankList else {
            return ""
        }
        return bankList[position].name
    }

    func bankListCount() -> Int {
        guard let bankList = bankList else {
            return 0
        }
        return bankList.count
    }

    func bankListUrlImage(by position: Int) -> String {
        guard let bankList = bankList else {
            return ""
        }
        return bankList[position].secureThumbnail
    }

    func setSelectedBankId(by position: Int) {
        selectedBankId = bankList?[position].id ?? ""
    }

    func onContinueButtonPressed() {
        var updatedTransactionData = transactionData
        updatedTransactionData.issuerId = selectedBankId
        delegate?.goToQuotaSelection(with: updatedTransactionData)
    }
}

// MARK: - BankSelectionInteractorOutputProtocol
extension BankSelectionPresenter: BankSelectionInteractorOutputProtocol {
    func onGetBankListResponse() {
        view?.stopActivityIndicator()
    }

    func onGetBankListSuccess(response: [Bank]) {
        bankList = response
    }

    func onGetBankListFailure() {
        delegate?.onErrorView(with: "Ha ocurrido un error, te redirigiremos al comienzo")
    }
}
