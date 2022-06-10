//
//  AppCoordinator.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//

import UIKit

// MARK: - TransactionDataProtocol
protocol TransactionDataProtocol {
    /// Initial view, typed user amount
    var amount: String? { set get }
    /// Selected payment card id
    var paymentId: String? { set get }
    /// Selected payment type
    var paymentType: String? { set get }
    /// Selected payment
    var payment: String? { set get }
}

// MARK: - TransactionData
class TransactionData: TransactionDataProtocol {
    var amount: String?
    var paymentId: String?
    var paymentType: String?
    var payment: String?
}

// MARK: - Coordinator
protocol Coordinator: AnyObject {
    func start()
}

// MARK: - AppCoordinatorProtocol
protocol AppCoordinatorProtocol: Coordinator {}

// MARK: - AppCoordinator
final class AppCoordinator {
    let navigationController: UINavigationController
    private var transactionData: TransactionDataProtocol?

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
    func goToPaymentMethod(with data: TransactionDataProtocol) {
        self.transactionData = data
        guard let transactionData = transactionData else {
            return
        }
        let vc = PaymentMethodWireframe.createModule(with: self, transactionData: transactionData)
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

    func goToBankSelection(with transactionData: TransactionDataProtocol) {
        let vc = SplashWireframe.createModule(with: self)
        navigationController.pushViewController(vc, animated: true)
    }
}
