//
//  PaymentMethodInteractor.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//  
//

// MARK: - PaymentMethodInteractor
final class PaymentMethodInteractor {
    weak var interactorOutput: PaymentMethodInteractorOutputProtocol?
    var paymentMethodsManager: PaymentMethodsManagerProtocol

    required init(paymentMethodsManager: PaymentMethodsManagerProtocol) {
        self.paymentMethodsManager = paymentMethodsManager
    }
}

// MARK: - PaymentMethodInteractorProtocol
extension PaymentMethodInteractor: PaymentMethodInteractorProtocol {
    func onGetPaymentMethods() {
        let parameters = PaymentMethodsParameters(publicKey: APIEnvironment.publicKey)
        paymentMethodsManager.getPaymentMethods(with: parameters)
    }
}

// MARK: - PaymentMethodsManagerOutputProtocol
extension PaymentMethodInteractor: PaymentMethodsManagerOutputProtocol {
    func onPaymentMethodsResponse() {
        interactorOutput?.onPaymentMethodsResponse()
    }
    
    func onPaymentMethodsSuccess(response: [PaymentType]) {
        interactorOutput?.onPaymentMethodsSuccess(response: response)
    }
    
    func onPaymentMethodsFailure() {
        interactorOutput?.onPaymentMethodsFailure()
    }
}
