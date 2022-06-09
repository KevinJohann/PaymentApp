//
//  PaymentMethodPresenter.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//  
//

// MARK: - PaymentMethodPresenter
final class PaymentMethodPresenter {
    weak var view: PaymentMethodViewProtocol?
    var interactor: PaymentMethodInteractorProtocol?
    weak var delegate: PaymentMethodDelegate?

    private var paymentTypes: [PaymentType]? {
        didSet {
            guard let paymentTypes = paymentTypes else {
                return
            }
            view?.set(paymentTypes: paymentTypes)
        }
    }
}

// MARK: - PaymentMethodPresenterProtocol
extension PaymentMethodPresenter: PaymentMethodPresenterProtocol {
    func onViewDidLoad() {
        view?.startActivityIndicator()
        interactor?.onGetPaymentMethods()
    }

    func paymentMethodsCount() -> Int {
        guard let paymentTypes = paymentTypes else {
            return 0
        }
        return paymentTypes.count
    }

    func paymentMethodName(by position: Int) -> String {
        guard let paymentTypes = paymentTypes else {
            return ""
        }
        return paymentTypes[position].name
    }

    func paymentMethodUrlImage(by position: Int) -> String {
        guard let paymentTypes = paymentTypes else {
            return ""
        }
        return paymentTypes[position].secureThumbnail
    }
}

// MARK: - PaymentMethodInteractorOutputProtocol
extension PaymentMethodPresenter: PaymentMethodInteractorOutputProtocol {
    func onPaymentMethodsResponse() {
        view?.stopActivityIndicator()
    }

    func onPaymentMethodsSuccess(response: [PaymentType]) {
        self.paymentTypes = response
    }

    func onPaymentMethodsFailure() {
        delegate?.onErrorView(with: "Ha ocurrido un error, te redirigiremos al comienzo")
    }
}
