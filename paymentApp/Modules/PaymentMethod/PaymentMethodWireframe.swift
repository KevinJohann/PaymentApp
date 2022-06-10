//
//  PaymentMethodWireframe.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//  
//

import UIKit

// MARK: - PaymentMethodDelegate
protocol PaymentMethodDelegate: AnyObject {
    func onErrorView(with message: String)
    func goToBankSelection(with transactionData: TransactionDataProtocol)
}

// MARK: - PaymentMethodWireframe
enum PaymentMethodWireframe {
    static func createModule(with delegate: PaymentMethodDelegate, transactionData: TransactionDataProtocol) -> UIViewController {
        let paymentMethodsManager = PaymentMethodsManager()

        let view = PaymentMethodViewController.storyboardViewController()
        let presenter = PaymentMethodPresenter(transactionData: transactionData)
        let interactor = PaymentMethodInteractor(paymentMethodsManager: paymentMethodsManager)

        view.presenter = presenter
        
        interactor.interactorOutput = presenter
        paymentMethodsManager.managerOutput = interactor

        presenter.view = view
        presenter.interactor = interactor
        presenter.delegate = delegate
                
        return view
    }
}
