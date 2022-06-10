//
//  SplashPresenter.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//  
//

import Foundation

// MARK: - SplashPresenter
final class SplashPresenter {
    weak var view: SplashViewProtocol?
    weak var delegate: SplashDelegate?
}

// MARK: - SplashPresenterProtocol
extension SplashPresenter: SplashPresenterProtocol {
    func onViewWillAppear() {
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 2,
            execute: {
                self.delegate?.goToAmountRequested()
            }
        )
    }
}
