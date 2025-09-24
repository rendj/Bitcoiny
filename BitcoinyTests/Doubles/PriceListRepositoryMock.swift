import Foundation
@testable import Bitcoiny

final class PriceListRepositoryMock: PriceListRepositoryProtocol {
    private let prices: [Price]?
    private let error: Error?
    
    init(prices: [Price]?, error: Error?) {
        self.prices = prices
        self.error = error
    }
    
    func prices() async throws -> [Price] {
        if let prices {
            return prices
        }
        
        throw error ?? MockError.invalidConfiguration
    }
}
