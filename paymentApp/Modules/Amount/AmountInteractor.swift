//
//  AmountInteractor.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//  
//

// MARK: - AmountInteractor
final class AmountInteractor {
    weak var interactorOutput: AmountInteractorOutputProtocol?
    required init() {}
}

// MARK: - AmountInteractorProtocol
extension AmountInteractor: AmountInteractorProtocol {}
