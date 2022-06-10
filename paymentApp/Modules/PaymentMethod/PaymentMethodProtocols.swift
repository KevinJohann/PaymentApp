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
    func set(paymentTypes: [PaymentType], and typeId: String)
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
    func paymentMethodsCount(by typeId: String) -> Int
    func paymentTypeIdCount() -> Int
    func paymentMethodName(by position: Int, and typeId: String) -> String
    func paymentTypeIdName(by position: Int) -> String
    func paymentMethodUrlImage(by position: Int, and typeId: String) -> String
    func onContinueButtonPressed(with cardName: String)
    func paymentTypeId(by position: Int) -> String
}
