//
//  AppCoordinator.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//

import UIKit

// MARK: - Coordinator
protocol Coordinator: AnyObject {
    func start()
}

// MARK: - AppCoordinatorProtocol
protocol AppCoordinatorProtocol: Coordinator {}

// MARK: - AppCoordinator
final class AppCoordinator {
    let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        navigationController.isModalInPresentation = true
        navigationController.modalPresentationStyle = .fullScreen

        navigationController.setNavigationBarHidden(true, animated: false)

        self.navigationController = navigationController
    }
}

// MARK: - AppCoordinatorProtocol
extension AppCoordinator: AppCoordinatorProtocol {
    func start() {
        let vc = SplashWireframe.createModule(with: self)
        navigationController.pushViewController(vc, animated: true)
    }
}

// MARK: - SplashDelegate
extension AppCoordinator: SplashDelegate {
    func goToAmountRequested() {
        let amountVC = AmountWireframe.createModule(with: self)
        navigationController.pushViewController(amountVC, animated: true)
    }
}

// MARK: - AmountDelegate
extension AppCoordinator: AmountDelegate {
    func goToPaymentMethod(with amountData: String) {
        print(amountData)
        let vc = PaymentMethodWireframe.createModule(with: self)
        navigationController.pushViewController(vc, animated: true)
    }

    func onAlertRequested(errorMessage: String) {
        let nc = navigationController.topViewController
        nc?.presentAlertView(type: .customAlert(title: "Error", message: errorMessage))
    }
}

// MARK: - PaymentMethodDelegate
extension AppCoordinator: PaymentMethodDelegate {
    func onErrorView(with message: String) {
        let nc = navigationController.topViewController
        nc?.presentAlertView(
            type: .customAlert(
                title: "Error",
                message: message
            ),
            acceptAction: { _ in
                self.navigationController.popToRootViewController(animated: true)
            }
        )
    }
}
