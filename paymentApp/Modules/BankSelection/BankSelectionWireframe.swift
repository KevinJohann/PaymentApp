//
//  BankSelectionWireframe.swift
//  paymentApp
//
//  Created by Kevin on 09-06-22.
//  
//

import UIKit

// MARK: - BankSelectionDelegate
protocol BankSelectionDelegate: AnyObject {
    func onErrorView(with message: String)
    func goToQuotaSelection(with transactionData: TransactionDataProtocol)
}

// MARK: - BankSelectionWireframe
enum BankSelectionWireframe {
    static func createModule(with delegate: BankSelectionDelegate, transactionData: TransactionDataProtocol) -> UIViewController {        
        let bankListManager = BankListManager()

        let view = BankSelectionViewController.storyboardViewController()
        let presenter = BankSelectionPresenter(transactionData: transactionData)
        let interactor = BankSelectionInteractor(bankListManager: bankListManager)

        view.presenter = presenter
        
        interactor.interactorOutput = presenter
        bankListManager.managerOutput = interactor

        presenter.view = view
        presenter.interactor = interactor
        presenter.delegate = delegate
                
        return view
    }
}
