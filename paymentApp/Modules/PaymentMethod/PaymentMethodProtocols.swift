//
//  PaymentMethodProtocols.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//  
//

import UIKit

// MARK: - View
protocol PaymentMethodViewProtocol: AnyObject {
    func set(paymentTypes: [PaymentType])
    func startActivityIndicator()
    func stopActivityIndicator()
}

// MARK: - Interactor
protocol PaymentMethodInteractorProtocol: AnyObject {
    func onGetPaymentMethods()
}

// MARK: - InteractorOutput
protocol PaymentMethodInteractorOutputProtocol: AnyObject {
    func onPaymentMethodsResponse()
    func onPaymentMethodsSuccess(response: [PaymentType])
    func onPaymentMethodsFailure()
}

// MARK: - Presenter
protocol PaymentMethodPresenterProtocol: AnyObject {
    func onViewDidLoad()
    func paymentMethodsCount() -> Int
    func paymentMethodName(by position: Int) -> String
    func paymentMethodUrlImage(by position: Int) -> String
}
