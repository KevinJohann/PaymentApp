//
//  AmountWireframe.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//  
//

import UIKit

// MARK: - AmountDelegate
protocol AmountDelegate: AnyObject {
    func goToPaymentMethod(with data: TransactionDataProtocol)
    func onAlertRequested(errorMessage: String)
}

// MARK: - AmountWireframe
enum AmountWireframe {
    static func createModule(with delegate: AmountDelegate) -> UIViewController {
        let view = AmountViewController.storyboardViewController()
        let presenter = AmountPresenter()
        let interactor = AmountInteractor()

        view.presenter = presenter
        
        interactor.interactorOutput = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.delegate = delegate
                
        return view
    }
}
