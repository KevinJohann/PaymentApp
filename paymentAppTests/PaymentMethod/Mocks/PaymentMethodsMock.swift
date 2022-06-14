//
//  PaymentMethodsMock.swift
//  paymentAppTests
//
//  Created by Kevin on 13-06-22.
//

enum PaymentMethodsMock {
    case success, error
    var responseAsString: String {
        switch self {
        case .success: return
            """
            {
                "id": "amex",
                "name": "American Express",
                "payment_type_id": "credit_card",
                "status": "active",
                "secure_thumbnail": "https://http2.mlstatic.com/storage/logos-api-admin/b08cf800-4c1a-11e9-9888-a566cbf302df-xl@2x.png",
                "thumbnail": "https://http2.mlstatic.com/storage/logos-api-admin/b08cf800-4c1a-11e9-9888-a566cbf302df-xl@2x.png",
            }
            """
        case .error: return
            """
            {}
            """
        }
    }
}
//var id: String
//var name: String
//var paymentTypeId: String
//var status: String
//var secureThumbnail: String
//var thumbnail: String
//}
