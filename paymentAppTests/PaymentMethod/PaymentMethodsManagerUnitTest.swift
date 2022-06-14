//
//  PaymentMethodsManagerUnitTest.swift
//  paymentAppTests
//
//  Created by Kevin on 13-06-22.
//

import XCTest
import OHHTTPStubs
@testable import paymentApp

// MARK: - PaymentMethodsManagerUnitTest
class PaymentMethodsManagerUnitTest: XCTestCase {
    private var requestExpectation: XCTestExpectation?
    private enum ResponseExpectation: String { case go = "go", ok = "Success", error = "error" }

    lazy var manager: PaymentMethodsManagerProtocol = { [weak self] in
        let manager = PaymentMethodsManager()
        manager.managerOutput = self
        XCTAssertNotNil(manager)
        return manager
    }()

    override class func setUp() {
        super.setUp()
    }

    func testPaymentMethod() {
        let paymentMethodsMock: PaymentMethodsMock = .success
        let resp = paymentMethodsMock.responseAsString.encodeToJson()
        paymentMethods(statusCode: 200, jsonObject: resp)
        XCTAssertEqual(requestExpectation?.expectationDescription, ResponseExpectation.ok.rawValue)
    }
}

// MARK: - Utils
extension PaymentMethodsManagerUnitTest {
    private func setMsResponse(endpoint: String, statusCode: Int32, jsonObject: [String: Any]) {
        stub(condition: isPath(endpoint)) { _ in
            return HTTPStubsResponse(jsonObject: jsonObject, statusCode: statusCode, headers: nil)
        }
    }

    func paymentMethods(statusCode: Int32, jsonObject: [String: Any]) {
        let parameters = BankListParameters(publicKey: APIEnvironment.publicKey, paymentMethodId: "288")
        setMsResponse(
            endpoint: "https://api.mercadopago.com/v1/payment_methods",
            statusCode: statusCode,
            jsonObject: jsonObject
        )
        requestExpectation = expectation(description: ResponseExpectation.go.rawValue)
        manager.getPaymentMethods(with: parameters)

        guard let expectation = requestExpectation else {
            return
        }
        wait(for: [expectation], timeout: 500)
    }

    private func serviceCommonSuccess() {
        self.requestExpectation?.expectationDescription = ResponseExpectation.ok.rawValue
        self.requestExpectation?.fulfill()
    }

    private func serviceCommonFailure() {
        self.requestExpectation?.expectationDescription = ResponseExpectation.error.rawValue
        self.requestExpectation?.fulfill()
    }
}

// MARK: - PaymentMethodsParameters
extension PaymentMethodsManagerUnitTest: PaymentMethodsManagerOutputProtocol {
    func onPaymentMethodsResponse() {
//        serviceCommonSuccess()
    }
    
    func onPaymentMethodsSuccess(response: [PaymentType]) {
        serviceCommonSuccess()
    }
    
    func onPaymentMethodsFailure() {
        serviceCommonFailure()
    }
}
