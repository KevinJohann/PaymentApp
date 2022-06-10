//
//  BankSelectionProtocols.swift
//  paymentApp
//
//  Created by Kevin on 09-06-22.
//  
//

import UIKit

// MARK: - View
protocol BankSelectionViewProtocol: AnyObject {
    func startActivityIndicator()
    func stopActivityIndicator()
    func set(bankName: String)
}

// MARK: - Interactor
protocol BankSelectionInteractorProtocol: AnyObject {
    func onGetBankList(with paymentMethodId: String)
}

// MARK: - InteractorOutput
protocol BankSelectionInteractorOutputProtocol: AnyObject {
    func onGetBankListResponse()
    func onGetBankListSuccess(response: [Bank])
    func onGetBankListFailure()
}

// MARK: - Presenter
protocol BankSelectionPresenterProtocol: AnyObject {
    func onViewDidLoad()
    func bankName(by position: Int) -> String
    func bankListCount() -> Int
    func onContinueButtonPressed()
}
