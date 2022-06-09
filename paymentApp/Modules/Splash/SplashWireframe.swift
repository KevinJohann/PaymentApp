//
//  SplashWireframe.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//  
//

import UIKit

// MARK: - SplashDelegate
protocol SplashDelegate: AnyObject {
    func goToAmountRequested()
}

// MARK: - SplashWireframe
enum SplashWireframe {
    static func createModule(with delegate: SplashDelegate) -> UIViewController {
        let view = SplashViewController.storyboardViewController()
        let presenter = SplashPresenter()

        view.presenter = presenter
        
        presenter.view = view
        presenter.delegate = delegate
                
        return view
    }
}
