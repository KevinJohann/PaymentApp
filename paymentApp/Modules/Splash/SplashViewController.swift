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
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidAppear()
    }
}

// MARK: - SplashViewProtocol
extension SplashViewController: SplashViewProtocol {}
