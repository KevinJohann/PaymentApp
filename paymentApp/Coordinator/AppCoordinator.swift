//
//  AppCoordinator.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//

import UIKit
import Hero

// MARK: - TransactionDataProtocol
protocol TransactionDataProtocol {
    /// Initial view, typed user amount
    var amount: String? { set get }
    /// Selected payment card id
    var paymentMethodId: String? { set get }
    /// Selected payment type card name
    var paymentTypeCardName: String? { set get }
    /// Payment id
    var issuerId: String? { set get }
    /// Selected Quota text
    var selectedQuota: String? { set get }
}

// MARK: - TransactionData
class TransactionData: TransactionDataProtocol {
    var amount: String?
    var paymentMethodId: String?
    var paymentTypeCardName: String?
    var issuerId: String?
    var selectedQuota: String?
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
        navigationController.hero.isEnabled = true
        navigationController.pushViewController(vc, animated: true)
    }
}

// MARK: - SplashDelegate
extension AppCoordinator: SplashDelegate {
    func goToAmountRequested() {
        let amountVC = AmountWireframe.createModule(with: self, transactionData: nil)
        navigationController.setViewControllers([amountVC], animated: true)
    }
}

// MARK: - AmountDelegate
extension AppCoordinator: AmountDelegate {
    func goToPaymentMethod(with data: TransactionDataProtocol) {
        self.transactionData = data
        guard let transactionData = transactionData else {
            return
        }
        navigationController.isNavigationBarHidden = false
        let vc = PaymentMethodWireframe.createModule(with: self, transactionData: transactionData)
        navigationController.pushViewController(vc, animated: true)
    }

    func onAlertRequested(errorMessage: String) {
        let nc = navigationController.topViewController
        nc?.presentAlertView(type: .customAlert(title: "Error", message: errorMessage))
    }

    func openModal(with data: TransactionDataProtocol) {
        let vc = PaymentResumeViewController.storyboardViewController()
        vc.set(dataSource: data)
        navigationController.topViewController?.present(vc, animated: true, completion: nil)
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
        let vc = BankSelectionWireframe.createModule(with: self, transactionData: transactionData)
        navigationController.pushViewController(vc, animated: true)
    }
}

// MARK: - BankSelectionDelegate
extension AppCoordinator: BankSelectionDelegate {
    func goToQuotaSelection(with transactionData: TransactionDataProtocol) {
        let vc = QuotaSelectionWireframe.createModule(with: self, transactionData: transactionData)
        navigationController.pushViewController(vc, animated: true)
    }
}

// MARK: - QuotaSelectionDelegate
extension AppCoordinator: QuotaSelectionDelegate {
    func goToRootView(with transactionData: TransactionDataProtocol) {
        let amountVC = AmountWireframe.createModule(with: self, transactionData: transactionData)
        navigationController.setViewControllers([amountVC], animated: true)
    }
}
