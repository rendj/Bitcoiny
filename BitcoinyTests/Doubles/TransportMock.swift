import Foundation
@testable import Bitcoiny

final class TransportMock: TransportProtocol {
    private let statusCode: Int
    
    init(statusCode: Int) {
        self.statusCode = statusCode
    }
    
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        let response = HTTPURLResponse(
            url: URL(string: "https://api.coingecko.com")!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
        return (Data(), response)
    }
}
