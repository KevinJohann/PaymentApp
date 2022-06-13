//
//  QuotaSelectionWireframe.swift
//  paymentApp
//
//  Created by Kevin on 09-06-22.
//  
//

import UIKit

// MARK: - QuotaSelectionDelegate
protocol QuotaSelectionDelegate: AnyObject {
    func onErrorView(with message: String)
    func goToRootView(with transactionData: TransactionDataProtocol)
}

// MARK: - QuotaSelectionWireframe
enum QuotaSelectionWireframe {
    static func createModule(with delegate: QuotaSelectionDelegate, transactionData: TransactionDataProtocol) -> UIViewController {        
        let quotaManager = QuotaManager()
        let view = QuotaSelectionViewController.storyboardViewController()
        let presenter = QuotaSelectionPresenter(transactionData: transactionData)
        let interactor = QuotaSelectionInteractor(quotaManager: quotaManager)

        view.presenter = presenter
        
        interactor.interactorOutput = presenter
        quotaManager.managerOutput = interactor

        presenter.view = view
        presenter.interactor = interactor
        presenter.delegate = delegate
                
        return view
    }
}
