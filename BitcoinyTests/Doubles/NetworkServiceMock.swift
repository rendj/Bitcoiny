import Foundation
@testable import Bitcoiny

final class NetworkServiceMock: NetworkServiceProtocol {
    private let data: Data?
    private let error: Error?
    
    init(data: Data?, error: Error?) {
        self.data = data
        self.error = error
    }
    
    func fetch(_ endpoint: Endpoint) async throws -> Data {
        if let data {
            return data
        }
        throw error ?? MockError.invalidConfiguration
    }
}
