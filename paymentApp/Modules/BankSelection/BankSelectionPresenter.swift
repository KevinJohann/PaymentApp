//
//  BankSelectionPresenter.swift
//  paymentApp
//
//  Created by Kevin on 09-06-22.
//  
//

// MARK: - BankSelectionPresenter
final class BankSelectionPresenter {
    weak var view: BankSelectionViewProtocol?
    var interactor: BankSelectionInteractorProtocol?
    weak var delegate: BankSelectionDelegate?
    private let transactionData: TransactionDataProtocol
    
    private var bankList: [Bank]? {
        didSet {
            guard let bankList = bankList, let firstBank = bankList.first else {
                // Catch, make something
                return
            }
            
            view?.set(bankName: firstBank.name)
        }
    }
    init(transactionData: TransactionDataProtocol) {
        self.transactionData = transactionData
    }
}

// MARK: - BankSelectionPresenterProtocol
extension BankSelectionPresenter: BankSelectionPresenterProtocol {
    func onViewDidLoad() {
        view?.startActivityIndicator()

        guard let paymentId = transactionData.paymentId else {
            return
        }
        interactor?.onGetBankList(with: paymentId)
    }
    
    func bankName(by position: Int) -> String {
        guard let bankList = bankList else {
            return ""
        }
        return bankList[position].name
    }

    func bankListCount() -> Int {
        guard let bankList = bankList else {
            return 0
        }
        return bankList.count
    }

    func onContinueButtonPressed() {
        
    }
}

// MARK: - BankSelectionInteractorOutputProtocol
extension BankSelectionPresenter: BankSelectionInteractorOutputProtocol {
    func onGetBankListResponse() {
        view?.stopActivityIndicator()
    }

    func onGetBankListSuccess(response: [Bank]) {
        bankList = response
    }

    func onGetBankListFailure() {
        delegate?.onErrorView(with: "Ha ocurrido un error, te redirigiremos al comienzo")
    }
}
