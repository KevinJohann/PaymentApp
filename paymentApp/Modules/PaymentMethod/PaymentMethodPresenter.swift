//
//  PaymentMethodPresenter.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//  
//

import Foundation
import SystemConfiguration

// MARK: - PaymentMethodPresenter
final class PaymentMethodPresenter {
    weak var view: PaymentMethodViewProtocol?
    weak var delegate: PaymentMethodDelegate?

    var interactor: PaymentMethodInteractorProtocol?
    private let transactionData: TransactionDataProtocol

    private var paymentTypes: [PaymentType]? {
        didSet {
            guard let paymentTypes = paymentTypes else {
                return
            }
            paymentTypes.forEach {
                let typeId = $0.paymentTypeId
                let containtsTypeId = paymentTypeId.contains { data in
                    data == typeId
                }
                if !containtsTypeId {
                    paymentTypeId.append($0.paymentTypeId)    
                }
            }
            guard let firstPaymentTypes = paymentTypes.first else {
                return
            }
            view?.setFirstPaymentTypes(data: firstPaymentTypes, and: paymentTypeId[0])
        }
    }

    private var paymentTypeId = [String]()

    init(transactionData: TransactionDataProtocol) {
        self.transactionData = transactionData
    }
}

// MARK: - PaymentMethodPresenterProtocol
extension PaymentMethodPresenter: PaymentMethodPresenterProtocol {
    func onViewDidLoad() {
        view?.startActivityIndicator()
        interactor?.onGetPaymentMethods()
    }

    func paymentMethodsCount(by typeId: String) -> Int {
        guard let paymentTypes = paymentTypes else {
            return 0
        }
        let filteredPaymentTypes = paymentTypes.filter {
            $0.paymentTypeId == typeId
        }
        return filteredPaymentTypes.count
    }

    func paymentTypeIdCount() -> Int {
        return paymentTypeId.count
    }

    func paymentMethodName(by position: Int, and typeId: String) -> String {
        guard let paymentTypes = paymentTypes else {
            return ""
        }
        let filteredPaymentTypes = paymentTypes.filter {
            $0.paymentTypeId == typeId
        }
        return filteredPaymentTypes[position].name
    }

    func paymentTypeIdName(by position: Int) -> String {
        return paymentTypeId[position]
    }

    func paymentType(by position: Int) -> String {
        guard let paymentTypes = paymentTypes else {
            return ""
        }
        
        return paymentTypes[position].name
    }

    func paymentMethodUrlImage(by position: Int, and typeId: String) -> String {
        guard let paymentTypes = paymentTypes else {
            return ""
        }
        let filteredPaymentTypes = paymentTypes.filter {
            $0.paymentTypeId == typeId
        }
        return filteredPaymentTypes[position].secureThumbnail
    }

    func paymentTypeId(by position: Int) -> String {
        paymentTypeId[position]
    }
    
    func onContinueButtonPressed(with cardName: String) {
        var updatedTransactionData = transactionData
        
        let filteredPaymentType = paymentTypes?.filter {
            $0.name == cardName
        }

        guard let paymentType = filteredPaymentType?.first else {
            return
        }
        
        updatedTransactionData.paymentTypeCardName = cardName
        updatedTransactionData.paymentMethodId = paymentType.id

        delegate?.goToBankSelection(with: updatedTransactionData)
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
