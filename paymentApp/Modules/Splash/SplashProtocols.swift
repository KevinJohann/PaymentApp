//
//  SplashProtocols.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//  
//

import UIKit

// MARK: - View
protocol SplashViewProtocol: AnyObject {}

// MARK: - Presenter
protocol SplashPresenterProtocol: AnyObject {
    func onViewDidAppear()
}
