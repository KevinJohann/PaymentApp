//
//  SplashPresenter.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//  
//

// MARK: - SplashPresenter
final class SplashPresenter {
    weak var view: SplashViewProtocol?
    weak var delegate: SplashDelegate?
}

// MARK: - SplashPresenterProtocol
extension SplashPresenter: SplashPresenterProtocol {
    func onViewDidAppear() { delegate?.goToAmountRequested() }
}
