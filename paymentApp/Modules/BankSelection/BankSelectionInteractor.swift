//
//  BankSelectionInteractor.swift
//  paymentApp
//
//  Created by Kevin on 09-06-22.
//  
//

// MARK: - BankSelectionInteractor
final class BankSelectionInteractor {
    weak var interactorOutput: BankSelectionInteractorOutputProtocol?
    var bankListManager: BankListManagerProtocol

    required init(bankListManager: BankListManagerProtocol) {
        self.bankListManager = bankListManager
    }
}

// MARK: - BankSelectionInteractorProtocol
extension BankSelectionInteractor: BankSelectionInteractorProtocol {
    func onGetBankList(with paymentMethodId: String) {
        let parameters = BankListParameters(publicKey: APIEnvironment.publicKey, paymentMethodId: paymentMethodId)
        bankListManager.getBankList(with: parameters)
    }
}

// MARK: - BankListManagerOutputProtocol
extension BankSelectionInteractor: BankListManagerOutputProtocol {
    func onGetBankListResponse() {
        interactorOutput?.onGetBankListResponse()
    }
    
    func onGetBankListSuccess(response: [Bank]) {
        interactorOutput?.onGetBankListSuccess(response: response)
    }
    
    func onGetBankListFailure() {
        interactorOutput?.onGetBankListFailure()
    }
}
