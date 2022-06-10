//
//  SplashViewController.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//  
//

import UIKit

// MARK: - SplashViewController
final class SplashViewController: UIViewController {
    var presenter: SplashPresenterProtocol?
}

// MARK: - Life cycles
extension SplashViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.onViewWillAppear()
    }
}

// MARK: - SplashViewProtocol
extension SplashViewController: SplashViewProtocol {}
