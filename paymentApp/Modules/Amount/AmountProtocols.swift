//
//  AmountProtocols.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//  
//

import UIKit

// MARK: - View
protocol AmountViewProtocol: AnyObject {
    func initializeButtonsConfiguration()
    func initializeCloseableKeyboard()
}

// MARK: - Interactor
protocol AmountInteractorProtocol: AnyObject {}

// MARK: - InteractorOutput
protocol AmountInteractorOutputProtocol: AnyObject {}

// MARK: - Presenter
protocol AmountPresenterProtocol: AnyObject {
    func onViewDidLoad()
    func onContinueButtonPressed(with amountData: String?)
}
