import Foundation
@testable import Bitcoiny

final class RealtimePriceRepositoryMock: RealtimePriceRepositoryProtocol {
    private let price: Price?
    var startWasCalled = false
    var stopWasCalled = false
    
    init(price: Price?) {
        self.price = price
    }
    
    func start(_ callback: @Sendable @escaping (Price) -> Void) {
        startWasCalled = true
        if let price {
            return callback(price)
        }
    }
    
    func stop() {
        stopWasCalled = true
    }
}
